require 'spec_helper'

describe PagesController do
  # by default RSpec just tests actions inside a controller test; if we want it
  # also to render the views, we have to tell it explicitly via the second line:
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
  describe "GET 'home'" do
    
    describe "when not signed in" do
      
      before(:each) do
        get :home
      end
      
      it "should be successful" do
        #get 'home'
        response.should be_success
      end
      
      it "should have the right title" do
        #get 'home'
        response.should have_selector("title",  :content => "#{@base_title} | Home")
      end
      
    end # End of describe "when not signed in"
    
    describe "when signed in" do
      
      before(:each)  do
        @user = test_sign_in( Factory(:user))
          other_user = Factory( :user, :email => Factory.next( :email))
          other_user.follow!( @user)
      end
      
      it "should have the right follower/following counts" do
        get :home
#        response.should have_selector("a", :href => following_user_path(@user),
#                                                                                   :content => "0 following")
        
#        response.should have_selector("a", :href => followers_user_path( @user),
#                                                                                  :content => "1 follower")
      end
    end # End of  describe "when signed in"
 end # End of describe "GET 'home'"

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => "Ruby on Rails Tutorial Sample App | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      # It’s worth mentioning that the content need not
      # be an exact match; any substring works as well, so that will also match the full title.
      response.should have_selector("title", :content => " | About")
    end
  end # End  of  describe "GET 'about'"
  
  
end
