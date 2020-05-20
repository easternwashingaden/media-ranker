require "test_helper"

describe VotesController do
  let (:work) {
    Work.create!(
      category: "album", 
      title: "My Coding Journey",
      creator: "Lak Mok",
      publication_year: "2020",
      description: "Ada makes my dream come true"
    )
  }
  
  let (:user) {
    User.create!(
      name: "Lak Mok"
    )
  }

  let (:vote) {
    Vote.create!(
      user_id: user.id,
      work_id: work.id
    )
  }
  

  # describe "create" do
  #   it "can create a new vote with valid information accurately and redirect" do
  #     # Arrange
  #     driver.update(available: true) # make sure there is at least one available driver, otherwise test will have an error

  #     # Act-Assert
  #     expect {
  #       post passenger_trips_path(passenger.id)
  #     }.must_differ "Trip.count", 1

  #     # Assert
  #     new_trip = Trip.find_by(date: Date.today)
  #     expect(new_trip.passenger_id).must_equal passenger.id
  #     expect(new_trip.driver_id).must_equal driver.id
  #     expect(new_trip.date).must_equal Date.today
  #     expect(new_trip.cost).must_be_kind_of Float
  #     expect(new_trip.rating).must_be_nil
      
  #     must_redirect_to passenger_path(passenger.id)
  #   end

  #   it "sets driver status to unavailable upon successfully creating a new trip" do
  #     driver.update(available: true)

  #     expect {
  #       post passenger_trips_path(passenger.id)
  #     }.must_differ "Trip.count", 1

  #     driver.reload
  #     expect(driver.available).must_equal false
  #   end

  #   it "does not create a trip if an invalid passenger id is given, and responds with a 400 error" do
  #     driver.update(available: true)

  #     expect {
  #       post passenger_trips_path(-1)
  #     }.wont_differ "Trip.count"

  #     must_respond_with :bad_request
  #   end
  # end
end
