require "test_helper"

describe Vote do
  before do
    @new_work = Work.new(
      category: "album", 
      title: "My Coding Journey",
      creator: "Lak Mok",
      publication_year: "2020",
      description: "Ada makes my dream come true"
    )
    @new_vote = Vote.new(
      user: users(:user3),
      work: works(:album8)
    )
  end

  it "can be instantiated" do
    expect(@new_vote.valid?).must_equal true
  end

  it "will have the required fields" do
    @new_vote.save
    vote= Vote.first
    [:user_id, :work_id].each do |field|
      # Assert
      expect(vote).must_respond_to field
    end
  end

  describe "relationships" do
    it "vote can link to only one user and work" do
      # Arrange
      @new_vote.save
      
      expect(@new_vote.user).must_be_instance_of User
    
      expect(@new_vote.work).must_be_instance_of Work
    
    end
  end

  describe "validations" do
    it "must have a work" do
      # Arrange
      @new_vote.work = nil

      # Assert
      expect(@new_vote.valid?).must_equal false
      expect(@new_vote.errors.messages).must_include :work
      expect(@new_vote.errors.messages[:work_id]).must_equal ["can't be blank"]
    end

    it "must have a user" do
      # Arrange
      @new_vote.user = nil

      # Assert
      expect(@new_vote.valid?).must_equal false
      expect(@new_vote.errors.messages).must_include :user
      expect(@new_vote.errors.messages[:user_id]).must_equal ["can't be blank"]
    end
  end

  # Test custom methods

  describe "count_votes" do

    it "returns the count of votes of a particular " do
      album5 = works(:album5)
      # From the fixture, there are 4 votes for album 5
      expect(Vote.count_votes(album5.id)).must_equal 4
    end
  end
end
