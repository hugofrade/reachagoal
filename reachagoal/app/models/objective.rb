class Objective < ActiveRecord::Base
    has_attached_file :photo,
      :styles => { :wide => "1000x400#", :dashboard => "500x300#" },
      :default_url => "/assets/objective/:style/placeholder.jpg",
      :url => "/system/objectives/:attachment/:id/:style/:filename",
      
      :path => ":rails_root/public/system/objectives/:attachment/:id/:style/:filename"
      
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
	has_many :objective_values
	has_many :user_objectives	
	
	def missing_value
	  if objective_values.length>0
	  	price - objective_values.map { |o| o.value }.inject{|sum,x| sum + x }
	  else
	   price
	  end
	end
	
	def completed_percentage 
		return (((self.price-self.missing_value)/self.price)*100)
	end
	
end
