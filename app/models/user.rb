class User < ApplicationRecord
	has_one :user_info
	has_many :boards
	has_many :collaborators, dependent: :destroy
end
