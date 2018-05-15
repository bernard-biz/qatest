require "selenium-webdriver"
require "page-object"
require_relative "./home_page"

class LoginPage
  include PageObject

  page_url('https://testers.testerwork.com/tester-account/sign-in')
  
  text_field(:email_field, :name =>'email')
  text_field(:password_field, :name => 'password')
  button(:log_in, :text => 'Log in')

  div(:error_message, :class => 'text-danger')
  div(:error_message_for_email, :xpath => '//div[input[@type="email"]]/div')
  div(:error_message_for_password, :xpath => '//div[input[@type="password"]]/div')

  def login_as(email, password)
    self.email_field = email
    self.password_field = password
    self.log_in
    return HomePage.new(@browser)
  end

end
 