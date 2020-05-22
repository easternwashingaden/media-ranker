require "test_helper"

describe User do
  let (:new_user){
    User.new(name: "Lak Mok")
  }

  it "can be instantiated" do
    # Assert
    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_user.save
    user = User.first
    [:name].each do |field|

      # Assert
      expect(user).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes and have many works through votes" do
      # Arrange
      new_user.save
      work1 = Work.create!(
        category: "album", 
        title: "My Coding Journey",
        creator: "Lak Mok",
        publication_year: "2020",
        description: "Ada makes my dream come true"
      )

      work2 = Work.create!(
        category: "book", 
        title: "Example title",
        creator: "Lak Mok",
        publication_year: "2020",
        description: "Ada makes my dream come true"
      )
      vote1 = Vote.create!(user_id: new_user.id, work_id: work1.id)
      vote2 = Vote.create!(user_id: new_user.id, work_id: work2.id)
      
      # Assert
      expect(new_user.votes.count).must_equal 2
      new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end

      expect(new_user.works.count).must_equal 2
      new_user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_user.name = nil

      # Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :name
      expect(new_user.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end 
end