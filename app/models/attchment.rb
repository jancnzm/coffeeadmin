class Attchment < ApplicationRecord
  has_attached_file :attchmentimg, :url => "/:attachment/:id/:basename.:extension",  :path => ":rails_root/public/attchmentimgs/:id/:basename.:extension"
  do_not_validate_attachment_file_type :attchmentimg
  belongs_to :pact
end
