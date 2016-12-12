class RemoteActiveRecord < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "remote_#{Rails.env}".to_sym

end
