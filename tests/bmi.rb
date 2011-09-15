#!/Users/jon/.rvm/rubies/ruby-1.9.2-head/bin/ruby

require 'rubygems'
require 'selenium-webdriver'

#hub = 'http://scalzi.is.localnet:4444/wd/hub'
hub = 'http://localhost:4444/wd/hub'
browser = :firefox

driver = Selenium::WebDriver.for :remote, :url => hub, :desired_capabilities => browser

driver.get "http://www.bmivisualizer.com"

puts "Page title is #{driver.title}"
driver.save_screenshot("./#{browser}.png")

driver.quit
