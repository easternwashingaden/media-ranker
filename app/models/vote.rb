class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, :work_id, presence: true

  def user
    return User.find_by(id: self.user_id)
  end


  def work
    return Work.find_by(id: self.work_id)
  end

  def self.count_votes(work_id)
    return Vote.where(work_id: work_id).count 
  end

  
end
