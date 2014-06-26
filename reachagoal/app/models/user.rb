class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   
   
   has_attached_file :photo,
      :styles => { :wide => "1000x400#", :dashboard => "500x500#", :thumb => "100x100#", :nav => "60x60#" },
      :default_url => "/assets/user/:style/placeholder.jpg",
      :url => "/system/user/:attachment/:id/:style/:filename",
      
      :path => ":rails_root/public/system/user/:attachment/:id/:style/:filename"
      
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/      
         
  has_many :objective_values
  has_many :user_objectives
  has_many :friends
  
         
end
