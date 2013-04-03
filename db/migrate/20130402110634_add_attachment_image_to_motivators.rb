class AddAttachmentImageToMotivators < ActiveRecord::Migration
  def self.up
    change_table :motivators do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :motivators, :image
  end
end
