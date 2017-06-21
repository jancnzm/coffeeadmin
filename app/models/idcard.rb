class Idcard < ApplicationRecord
  has_attached_file :idfront, :url => "/:attachment/:id/:basename.:extension",  :path => ":rails_root/public/idront/:id/:basename.:extension"
  do_not_validate_attachment_file_type :idfront
  has_attached_file :idback, :url => "/:attachment/:id/:basename.:extension",  :path => ":rails_root/public/idback/:id/:basename.:extension"
  do_not_validate_attachment_file_type :idback
end
