class Board < ApplicationRecord
	belongs_to :user
	has_many :columns, dependent: :destroy
	has_many :collaborators, dependent: :destroy
end
