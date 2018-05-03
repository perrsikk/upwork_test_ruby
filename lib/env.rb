require 'selenium-webdriver'

def setup
  # server = Selenium::Server.get :latest
  # server.start
  # @driver = Selenium::WebDriver.for :remote, desired_capabilities: :firefox

  @driver = Selenium::WebDriver.for :firefox
  @driver.manage.window.maximize
  # Selenium::WebDriver.logger.level = :debug
  ENV['base_url'] = 'https://www.upwork.com'
end

def delete_cookies
  @driver.manage.delete_all_cookies
end

def open_page(url)
  @driver.navigate.to(url)
  IndexPage.new(@driver)
end

def teardown
  @driver.quit
end

def run
  setup
  delete_cookies
  yield
  teardown
end
