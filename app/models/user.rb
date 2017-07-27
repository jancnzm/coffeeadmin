class User < ApplicationRecord
  has_secure_password
  
  has_many :pacts
  has_many :useramounts
  has_many :userpwds
  has_many :commissions
  has_many :withdraws
  
  has_attached_file :idfontimg, :url => "/:attachment/:id/:basename.:extension",  :path => ":rails_root/public/idfontimgs/:id/:basename.:extension"
  do_not_validate_attachment_file_type :idfontimg
  has_attached_file :idbackimg, :url => "/:attachment/:id/:basename.:extension",  :path => ":rails_root/public/idbackimgs/:id/:basename.:extension"
  do_not_validate_attachment_file_type :idbackimg

  has_many :childrens, class_name: "User", foreign_key: "up_id"
  belongs_to :parent, class_name: "User", foreign_key: "up_id"

  has_many :invitecodes

end
