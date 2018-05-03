require_relative '../lib/env'

class Base

  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  def refresh_page
    driver.navigate.refresh
  end

  def visit(url='/')
    driver.get(ENV['base_url'] + url)
  end

  def find(locator)
    driver.find_element locator
  end

  def find_all(locator)
    driver.find_elements locator
  end

  def clear(locator)
    find(locator).clear
  end

  def type(locator, input)
    find(locator).send_keys input
  end

  def click_on(locator)
    find(locator).click
  end

  def displayed?(locator)
    find(locator).displayed?
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def text_of(locator)
    find(locator).text
  end

  def wait(seconds=2)
    Selenium::WebDriver::Wait.new(:timeout => seconds)
  end

  def wait_for(seconds=10)
    Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }
  end

  def page_loaded?
    wait_for { driver.execute_script('return document.readyState;') == 'complete' }
  end

  def submit(locator)
    find(locator).submit
  end
end