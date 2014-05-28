class Objective < ActiveRecord::Base
    has_attached_file :photo,
      :styles => { :medium => "300x300>", :thumb => "100x100>" },
      :default_url => "/images/:style/missing.png",
      :url => "/system/:attachment/:id/:style/:filename",
      :path => ":rails_root/public/system/:attachment/:id/:style/:filename"
      
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
	has_many :objective_values
	has_many :user_objectives	
	
	def missing_value
	  if objective_values.length >0
	  	price - objective_values.map { |o| o.value }.inject{|sum,x| sum + x }
	  else
	   0
	  end
	end

end
