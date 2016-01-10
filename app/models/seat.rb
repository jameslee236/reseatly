class Seat < ActiveRecord::Base
	has_many :records
	has_many :users, :through => :records
	belongs_to :owner, class_name: "User"
end
