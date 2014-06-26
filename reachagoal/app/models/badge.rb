class Badge < ActiveRecord::Base

	has_attached_file :icon,
      :styles => { :icon => "60x60#" },
      :default_url => "/assets/badges/:style/placeholder.jpg",
      :url => "/system/badges/:attachment/:id/:style/:filename",
      :path => ":rails_root/public/system/badges/:attachment/:id/:style/:filename"
      
    validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
	has_many :user_badges
end
