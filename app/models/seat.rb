class Seat < ActiveRecord::Base
	has_many :records
	has_many :users, :through => :records
	belongs_to :owner, class_name: "User"
	validates :owner_id, uniqueness: true
	validate :owner_id_greater_than_zero

	def owner_id_greater_than_zero
		if owner_id < 0
			errors.add(:seat, "Owner does not exist")
		end
	end

	def owner_must_exist
		if User.find_by(user_id: owner_id).nil?
			errors.add(:seat, "The owner you're trying to assign doesn't exist")
		end
	end
end
