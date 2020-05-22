class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :work_id}
  validates :work_id, presence: true, uniqueness: { scope: :user_id}
  
  def self.count_votes(work_id)
    return Vote.where(work_id: work_id).count 
  end

end
