class Seat < ActiveRecord::Base
	has_many :records
	has_many :users, :through => :records
end
