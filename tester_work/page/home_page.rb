require "selenium-webdriver"
require "page-object"

class HomePage
	include PageObject
	
	page_url('https://testers.testerwork.com/tester-account')

	link(:profile_link, :href => '/tester-account/profile/dashboard')
	
	def logged_in?(email)
		if self.profile_link_element.when_visible
			return true
		else
			return false
		end
	end
	
end
 