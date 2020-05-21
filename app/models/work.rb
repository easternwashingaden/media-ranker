class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category} # Allow user to add the same existing title with different category
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  def self.top_ten_list(category)
    return Work.where(category: category).max_by(10) {|work| work.votes.count}
  end

  def self.spot_light
    return Work.all.max_by {|work| work.votes.count}
  end

  def self.order_by_votes_count(category)
    return Work.where(category: category).sort_by {|work| -work.votes.count}
  end
end
