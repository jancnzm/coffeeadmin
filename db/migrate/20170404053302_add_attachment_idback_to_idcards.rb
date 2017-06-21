class AddAttachmentIdbackToIdcards < ActiveRecord::Migration
  def self.up
    change_table :idcards do |t|
      t.attachment :idback
    end
  end

  def self.down
    remove_attachment :idcards, :idback
  end
end
