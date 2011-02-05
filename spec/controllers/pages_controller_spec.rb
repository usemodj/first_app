require 'spec_helper'

describe PagesController do
  # by default RSpec just tests actions inside a controller test; if we want it
  # also to render the views, we have to tell it explicitly via the second line:
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",  :content => "Ruby on Rails Tutorial Sample App | Home")
    end
  end

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
  end
  
  
end
