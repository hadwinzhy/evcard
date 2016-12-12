#encoding:utf-8
namespace :evcard do
  desc "TODO"
  task fetch_all_shop: :environment do
    domain = 'http://www.evcardchina.cn'
    shop_url = '/api/proxy/getShopInfoList'

    conn = Faraday.new(:url => domain) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      # faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.get shop_url
    raise "fetch network error #{response.code}" if response.status != 200

    JSON.parse(response.body).each do |shop_data|
      shop = Shop.find_or_initialize_by(shop_seq: shop_data['shopSeq'])
      shop.shop_name = shop_data['shopName']
      shop.shop_desc = shop_data['shopDesc']
      shop.allow_stack_cnt = shop_data['allowStackCnt']
      shop.address = shop_data['address']
      shop.save
    end
  end

  desc "TODO"
  #rake evcard:get_car_in_shop\['中信'\]
  task :get_car_in_shop,  [:shop_keyword] => :environment do |t, args|
    shop = Shop.search args.shop_keyword
    raise "No shop found for #{args.shop_keyword}" unless shop

    p "找到停车点 #{shop.shop_name}, 停车位共 #{shop.allow_stack_cnt} 个"
    conn = Faraday.new(:url => 'http://www.evcardchina.cn') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      # faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.post do |req|
      req.url 'api/proxy/getVehicleInfoList'
      req.headers['Content-Type'] = 'application/json'
      req.body = {shopSeq: shop.shop_seq}.to_json
    end

    car_data = JSON.parse(response.body)
    can_rent_car = car_data.select {|car| car['canRent'] == 1 }
    cannot_rent_car = car_data.select {|car| car['canRent'] == 0 }

    if(can_rent_car.present?)
      p "发现可用车 #{can_rent_car.count} 辆!!!"
      p can_rent_car
      p "同时可能停着 #{cannot_rent_car.count} 辆车"
    else
      puts "抱歉没有发现可用车, 但可能停着 #{cannot_rent_car.count} 辆车"
    end
  end

end
