require 'selenium-webdriver'
require_relative '../page/main_page'

hostname = ENV['SELENIUM-HOSTNAME'] || "localhost"
port = ENV['SELENIUM-PORT'] || "4444"
browser = ENV['SELENIUM-BROWSER'] || "chrome"

describe "Registration" do 
  before(:all) do 
    @driver = Selenium::WebDriver.for :remote, url: "http://"+hostname+":"+port+"/wd/hub", desired_capabilities: :"#{browser}"
  end 
   
  before(:each) do 
    @main_page = MainPage.new(@driver, true)
    @registration_page = @main_page.goto_registration_page()
  end 
   
  before(:each, :registration => true) do 
    @username = ('a'..'z').to_a.shuffle.first(8).join
  end 
   
  after(:all) do
    @driver.quit
  end
   
  context "With valid input", :positive => true do   
    it "should signup when correct email, password and accepted terms", :registration => true, :smoke => true do 
      @registration_successful_page = @registration_page.signup_as(@username+"@testerwork.com", "1234Qwerty", "1234Qwerty", true)	 
      expect(@registration_successful_page.signed_up?).to be true
    end 
  end 
   
  context "With invalid input", :negative => true do   
    it "should not signup when incorrect email" do 
      @registration_page.signup_as("invalidemail", "1234Qwerty", "1234Qwerty", false)	 
      expect(@registration_page.error_message_for_email).to eq("is not a valid email")
    end 
    it "should not signup when blank email" do 
      @registration_page.signup_as("", "1234Qwerty", "1234Qwerty", false)	 
      expect(@registration_page.error_message_for_email).to eq("can't be blank")
    end 
    it "should not signup when blank password" do 
      @registration_page.signup_as("mail@testerwork.com", "", "", false)	 
      expect(@registration_page.error_message_for_password).to eq("can't be blank")
    end
    it "should not signup when password is too short" do 
      @registration_page.signup_as("mail@testerwork.com", "1234567", "1234567", false)	 
      expect(@registration_page.error_message_for_password).to eq("is too short (minimum is 8 characters)")
    end
    it "should not signup when password does not meet criteria" do 
      @registration_page.signup_as("mail@testerwork.com", "aaaaaaaa", "aaaaaaaa", true)	 
      expect(@registration_page.error_message_for_password).to eq("must contain big, small letters and digits")
    end
    it "should not signup when blank email and password" do 
      @registration_page.signup_as("", "", "", false)	 
      expect(@registration_page.error_message_for_email).to eq("can't be blank")
      expect(@registration_page.error_message_for_password).to eq("can't be blank")
    end
    it "should not signup when passwords does not match" do 
      @registration_page.signup_as("mail@testerwork.com", "12345Qwerty", "Qwerty12345", false)	 
      expect(@registration_page.error_message_for_password_confirmation).to eq("Password confirmation and Password must match")
    end 
    it "should not signup when terms of service not accepted" do 
      @registration_page.signup_as("mail@testerwork.com", "12345Qwerty", "12345Qwerty", false)	 
      expect(@registration_page.error_message_for_checkbox).to eq("Please accept the Tester Work Terms of Service before continuing")
    end	  
  end 
end
