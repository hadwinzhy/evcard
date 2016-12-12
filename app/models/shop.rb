class Shop < ActiveRecord::Base
  scope :by_keywords, lambda{ |keyword| where("shop_name LIKE ?", "%#{keyword}%")}

  def self.search keyword
    # return the first one
    return unless keyword

    Shop.by_keywords(keyword).take
  end


end
