require "selenium-webdriver"
require "page-object"
require_relative "./registration_successful_page"

class RegistrationPage
  include PageObject

  page_url('https://testers.testerwork.com/tester-account/sign-up')

  text_field(:email_field, :name =>'email')
  text_field(:password_field, :name => 'password')
  text_field(:password_confirmation_field, :name => 'password_confirmation')
  div(:checkbox, :class => 'checkbox')
  button(:sign_up, :text => 'Get started')

  div(:error_message_for_email, :xpath => '//form/ul/li[input[@name="email"]]/div')
  div(:error_message_for_password, :xpath => '//form/ul/li[input[@name="password"]]/div')
  div(:error_message_for_password_confirmation, :xpath => '//form/ul/li[input[@name="password_confirmation"]]/div')
  div(:error_message_for_checkbox, :xpath => '//form/ul/li[div[@class="checkbox"]]/div/div')

  def signup_as(email, password, password_confirmation, accept)
    self.email_field = email
    self.password_field = password
    self.password_confirmation_field = password_confirmation
    if accept 
      self.checkbox_element.click
    end
    self.sign_up
    return RegistrationSuccessfulPage.new(@browser)
  end

end
 