class User < ApplicationRecord
	has_one :user_info
	has_many :boards
end
