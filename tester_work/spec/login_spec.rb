require 'selenium-webdriver'
require_relative '../page/main_page'
require_relative '../page/registration_page'

hostname = ENV['SELENIUM-HOSTNAME'] || "localhost"
port = ENV['SELENIUM-PORT'] || "4444"
browser = ENV['SELENIUM-BROWSER'] || "chrome"

describe "Login" do 
   before(:all) do 
	  @driver = Selenium::WebDriver.for :remote, url: "http://"+hostname+":"+port+"/wd/hub", desired_capabilities: :"#{browser}"
   end 
   
   before(:each, :login => false) do 
	  @main_page = MainPage.new(@driver, true)
	  @login_page = @main_page.goto_login_page()
   end 
   
   before(:each, :login => true) do 
	  @username = ('a'..'z').to_a.shuffle.first(8).join
	  @password = ('a'..'z').to_a.shuffle.first(8).join + ('0'..'9').to_a.shuffle.first(3).join + ('A'..'Z').to_a.shuffle.first(5).join
	  @registration_page = RegistrationPage.new(@driver, true)
	  @registration_page.signup_as(@username+"@testerwork.com", @password, @password, true)
	  @main_page = MainPage.new(@driver, true)
	  @login_page = @main_page.goto_login_page()
   end 
   
   after(:all) do
	  @driver.quit
   end
   
   context "With valid input", :login => true, :positive => true do   
      it "should login when correct email and password", :smoke => true do 
		 @home_page = @login_page.login_as(@username+"@testerwork.com", @password)	 
		 expect(@home_page.logged_in?(@username+"@testerwork.com")).to be true
      end 
   end
   
   context "With invalid input", :login => false, :negative => true do 
      it "should not login when incorrect email and password" do 
		 @login_page.login_as("mail@gmail.com", "password")	 
		 expect(@login_page.error_message).to eq("Invalid email or password.") 
      end 
	  
	  it "should not login when blank email" do 
		 @login_page.login_as("", "password")	 
		 expect(@login_page.error_message_for_email).to eq("can't be blank") 
      end 
		
	  it "should not login when blank password" do 
		 @login_page.login_as("mail@gmail.com", "")	 
		 expect(@login_page.error_message_for_password).to eq("can't be blank") 
      end 
	  
	  it "should not login when blank email and password" do 
		 @login_page.login_as("", "")	 
		 expect(@login_page.error_message_for_email).to eq("can't be blank")
		 expect(@login_page.error_message_for_password).to eq("can't be blank") 
      end 
   end 
end
