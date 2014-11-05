class ObjectiveValue < ActiveRecord::Base

  belongs_to :user
  belongs_to :objective
  validates_presence_of :value
  validates :value, numericality: true
  
end
