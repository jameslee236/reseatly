class User < ActiveRecord::Base
	has_many :records
	has_many :seats, :through => :records
end
