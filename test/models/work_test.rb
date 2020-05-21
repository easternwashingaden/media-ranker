require "test_helper"

describe Work do
  before do
    @new_work = Work.new(
      category: "album", 
      title: "My Coding Journey",
      creator: "Lak Mok",
      publication_year: "2020",
      description: "Ada makes my dream come true"
    )
  end

  it "can be instantiated" do
    # Assert
    expect(@new_work.valid?).must_equal true

  end

  it "will have the required fields" do
    # Arrange
    @new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes and have many users through votes" do
      # Arrange
      @new_work.save
      album5 = works(:album5)
      
      # Assert
      expect(@new_work.votes.count).must_equal 0 # no votes for new_work
      expect(album5.votes.count).must_equal 4
      album5.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
      expect(album5.users.count).must_equal 4
      @new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  describe "validations" do
    it "must have a category" do
      # Arrange
      @new_work.category = nil

      # Assert
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :category
      expect(@new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      # Arrange
      @new_work.title = nil
      

      # Assert
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :title
      expect(@new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a unique title" do
      # Arrange
      @new_work.save
      another_work = Work.new(
        category: "album", 
        title: "My Coding Journey",
        creator: "Lak Mok",
        publication_year: "2020",
        description: "Ada makes my dream come true"
      )

      # Assert
     
      expect(another_work.valid?).must_equal false
      expect{flash.new[:error]}.must_raise "Something went wrong. Work was NOT added 😞"
      expect(another_work.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it "allow user the add a new work with the same existing title with a different category" do
      # Arrange
      another_work = Work.new(
        category: "book", 
        title: "My Coding Journey",
        creator: "Lak Mok",
        publication_year: "2020",
        description: "Ada makes my dream come true"
      )

      # Assert
     
      expect(another_work.valid?).must_equal true
    end

    it "must have a creator" do
      # Arrange
      @new_work.creator = nil

      # Assert
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :creator
      expect(@new_work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it "must have a publication_year" do
      # Arrange
      @new_work.publication_year = nil

      # Assert
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :publication_year
      expect(@new_work.errors.messages[:publication_year]).must_equal ["can't be blank"]
    end

    it "must have a description" do
      # Arrange
      @new_work.description= nil

      # Assert
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :description
      expect(@new_work.errors.messages[:description]).must_equal ["can't be blank"]
    end
  end

  # Tests all the custom functions 

  describe "custom methods" do
    describe "top_ten_list" do
      # For album
      it "returns an array of top ten albums that have most votes" do
        top_ten_ablums = Work.top_ten_list(:album)
        expect(top_ten_ablums).must_be_instance_of Array
        expect(top_ten_ablums.length).must_equal 10
        top_ten_ablums.each do |work|
          expect(work).must_be_instance_of Work
        end
      end
      it "returns the top ten list of albums that have most votes in descending order " do
        # album 5 has most votes, 4 votes
        top_album = works(:album5)
        expect(Work.top_ten_list(:album).first).must_equal top_album
        expect(Work.top_ten_list(:album).first.votes.count).must_equal 4
      end

      # For book
      it "returns an array of top ten books that have most votes" do
        top_ten_books = Work.top_ten_list(:book)
        expect(top_ten_books).must_be_instance_of Array
        expect(top_ten_books.length).must_equal 5
        top_ten_books.each do |work|
          expect(work).must_be_instance_of Work
        end
      end
      it "returns the top ten list of albums that have most votes in descending order " do
        # book4 has most votes, 3 votes
        top_book= works(:book4)
        expect(Work.top_ten_list(:book).first).must_equal top_book
        expect(Work.top_ten_list(:book).first.votes.count).must_equal 3
      end

      # For movie
      it "returns an array of top ten albums that have most votes" do
        top_ten_movies = Work.top_ten_list(:movie)
        expect(top_ten_movies).must_be_instance_of Array
        expect(top_ten_movies.length).must_equal 1
        top_ten_movies.each do |work|
          expect(work).must_be_instance_of Work
        end
      end

      it "returns the top ten list of albums that have most votes in descending order " do
        # movie has 0 votes
        top_movie= works(:movie1)
        expect(Work.top_ten_list(:movie).first).must_equal top_movie
        expect(Work.top_ten_list(:movie).first.votes.count).must_equal 0
      end

    end
    describe "spot_light" do
      it "returns one Work that has the most votes" do
        # From the fixture, album5 has the most votes
        top_work = works(:album5)
        expect(Work.spot_light).must_be_instance_of Work
        expect(Work.spot_light).must_equal top_work
        expect(Work.spot_light.votes.count).must_equal 4
      end
    end
    describe "order_by_votes_count by category" do
      # For album
      it "returns an sorted array of works (ablums) based on the vote counts in descending order" do
         # In the fixture, album5 has the most votes
        top_album = works(:album5)
        
        expect(Work.order_by_votes_count(:album).first).must_equal top_album
        expect(Work.order_by_votes_count(:album).first.votes.count).must_equal 4
      end

      it "returns an sorted array of works (books) based on the vote counts in descending order" do
        # In the fixture, book4 has the most votes
        top_book = works(:book4)

        expect(Work.order_by_votes_count(:book).first).must_equal top_book
        expect(Work.order_by_votes_count(:book).first.votes.count).must_equal top_book.votes.count
      end

      it "returns an sorted array of works (movies) based on the vote counts in descending order" do
        # In the fixture, book4 has the most votes
        top_movie = works(:movie1)
        expect(Work.order_by_votes_count(:movie).first).must_equal top_movie
        expect(Work.order_by_votes_count(:movie).first.votes.count).must_equal top_movie.votes.count
      end
    end
  end 
end
