require "selenium-webdriver"
require "page-object"
require_relative "./login_page"
require_relative "./registration_page"

class MainPage
	include PageObject
	
	page_url('http://testerwork.com')
	
	link(:login_link, :href => 'http://testerwork.com/login/')
	link(:registration_link, :href => 'http://testerwork.com/signup/')
	
	def goto_login_page()
		self.login_link
		return LoginPage.new(@browser)
	end
	
	def goto_registration_page()
		self.registration_link
		return RegistrationPage.new(@browser)
	end
end
 