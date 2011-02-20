require 'spec_helper'

describe "Microposts" do
#  describe "GET /microposts" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get microposts_path
#      response.status.should be(200)
#    end
#  end
  
  before(:each) do
    user = Factory( :user)
    visit signin_path
    fill_in :email ,  :with => user.email
    fill_in :password,  :with => user.password
    click_button
  end
  
  describe "creation" do
    
    describe "failure" do
      
      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content,  :with => " "
          click_button
          response.should  render_template( 'pages/home')
          response.should have_selector( "div#error_explanation")
        end.should_not  change( Micropost,  :count)
      end
    end # End of describe "failure"
    
    describe "success" do
      
      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :micropost_content,  :with => content
          click_button
          response.should have_selector( "span.content", :content => content)
        end.should change( Micropost,  :count).by( 1)
        end
    end
  end # End  of describe "creation"
end