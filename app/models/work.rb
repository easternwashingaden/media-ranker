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

  # def self.order_by_votes_count(category)
  #   highest_vote_count = 0
  #   works_list_order_by_votes_count = []
  #   works = Work.where(category: category)
  #   works.each |work|
  #     if work.votes.count > highest_vote_count
  #       highest_vote_count = work.votes.count
  #       works_list_order_by_votes_count << 
  # end
  
end
