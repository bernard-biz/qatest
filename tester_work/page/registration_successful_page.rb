require "selenium-webdriver"
require "page-object"

class RegistrationSuccessfulPage
	include PageObject

	h1(:welcome_field, :text =>'Welcome to the Tester Work Community!')
	
	def signed_up?()
		if self.welcome_field_element.when_visible
			return true
		else
			return false
		end
		
	end
	
end
 