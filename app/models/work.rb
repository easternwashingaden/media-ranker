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

    hash = Hash.new(0)

    works.each do |work|
      hash[work] = work.votes.count
    end
    
    sorted_hash = hash.sort_by {|key, value| -value}
    sorted_hash_keys = sorted_hash.to_h.keys
    return sorted_hash_keys.take(10)
  end

  def self.spot_light
    works = Work.all

    hash = Hash.new(0)
    works.each do |work|
      hash[work] = work.votes.count
    end

    most_voted_work = hash.max_by { |key, value| value}
    return most_voted_work.first
  end

  def self.order_by_votes_count(category)
    works = Work.where(category: category)

    hash = Hash.new(0)
    works.each do |work|
      hash[work] = work.votes.count
    end

    sorted_hash = hash.sort_by {|key, value| -value}
    return sorted_hash.to_h.keys
  end
end
