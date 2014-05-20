class AddAttachmentPhotoToObjectives < ActiveRecord::Migration
  def self.up
    change_table :objectives do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :objectives, :photo
  end
end
