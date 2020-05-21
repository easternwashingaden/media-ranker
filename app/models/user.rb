class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  validates :name, presence: true
end
