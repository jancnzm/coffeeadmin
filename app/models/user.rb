class User < ApplicationRecord
  has_secure_password
  
  has_many :pacts
  has_many :useramounts
  has_many :userpwds
  
  has_attached_file :idfontimg, :url => "/:attachment/:id/:basename.:extension",  :path => ":rails_root/public/idfontimgs/:id/:basename.:extension"
  do_not_validate_attachment_file_type :idfontimg
  has_attached_file :idbackimg, :url => "/:attachment/:id/:basename.:extension",  :path => ":rails_root/public/idbackimgs/:id/:basename.:extension"
  do_not_validate_attachment_file_type :idbackimg
end
