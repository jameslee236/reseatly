class Seat < ActiveRecord::Base
	has_many :records
	has_many :users, :through => :records
	belongs_to :owner, class_name: "User"
	validates :owner_id, uniqueness: true
	validate :owner_id_greater_than_zero
end
