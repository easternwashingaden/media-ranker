require "test_helper"

describe UsersController do
  it "can get the login form" do 
    get login_path

    must_respond_with   :success
  end

  describe "loggin in" do 
    it "can login a new user" do 
      user = nil
      expect {
        user = login()
      }.must_differ "User.count", 1

      must_respond_with :redirect
      
      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id 
      expect(user.name).must_equal "Lak Mok"
    end

    it "can login an existing user" do
      user = User.create(name: "Jeta Cathy")

      expect {
        login(user.name)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id 
    end
  end

  describe "logout" do
    it "can logout a logged in user" do
      # Arrange
      login()
      expect(session[:user_id]).wont_be_nil

      # Act
      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end

  describe "current user" do
    it "can return the pate if the user is logged in" do
      # Arrage
      login()

      # Act
      get current_user_path

      # Assert
      must_respond_with :success
    end

    it "redirects us back if the user is not logged in" do
      # Act
      get current_user_path

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "You must be logged in to view this page"
    end 
  end
end
