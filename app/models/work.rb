class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, presence: true
  validates :title, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  def self.top_ten_list(category)
    works = Work.where(category: category)
    return works.limit(10)
  end

  def self.spot_light
    works = Work.all
    return works.sample
  end
end
