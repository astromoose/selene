#!/Users/jon/.rvm/rubies/ruby-1.9.2-head/bin/ruby

require 'rubygems'
require 'selenium-webdriver'
require 'awesome_print'
require 'peach'

hub = 'http://scalzi.is.localnet:4444/wd/hub'

# Browser defs
wie6 = Selenium::WebDriver::Remote::Capabilities.ie(:takes_screenshot => true, :version => '6', :platform => 'WINDOWS')
wie7 = Selenium::WebDriver::Remote::Capabilities.ie(:takes_screenshot => true, :version => '7', :platform => 'WINDOWS')
wie8 = Selenium::WebDriver::Remote::Capabilities.ie(:takes_screenshot => true, :version => '8', :platform => 'WINDOWS')
wie9 = Selenium::WebDriver::Remote::Capabilities.ie(:takes_screenshot => true, :version => '9', :platform => 'WINDOWS')
wff6 = Selenium::WebDriver::Remote::Capabilities.firefox(:takes_screenshot => true, :version => '6.0.2', :platform => 'WINDOWS')
wff7 = Selenium::WebDriver::Remote::Capabilities.firefox(:takes_screenshot => true, :version => '7.0', :platform => 'WINDOWS')
wchr = Selenium::WebDriver::Remote::Capabilities.chrome(:takes_screenshot => true, :platform => 'WINDOWS')
lff6 = Selenium::WebDriver::Remote::Capabilities.firefox(:takes_screenshot => true, :version => '6.0.2', :platform => 'LINUX')
lff3 = Selenium::WebDriver::Remote::Capabilities.firefox(:takes_screenshot => true, :version => '3.6', :platform => 'LINUX', :firefox_binary => '/opt/ff3/firefox')
lff7 = Selenium::WebDriver::Remote::Capabilities.firefox(:takes_screenshot => true, :version => '7.0', :platform => 'LINUX', :firefox_binary => '/opt/ff7/firefox')
lchr = Selenium::WebDriver::Remote::Capabilities.chrome(:takes_screenshot => true, :platform => 'LINUX', :chrome_binary => '/usr/bin/google-chrome')
lopr = Selenium::WebDriver::Remote::Capabilities.opera(:takes_screenshot => true, :platform => 'LINUX')
mff6 = Selenium::WebDriver::Remote::Capabilities.firefox(:takes_screenshot => true, :platform => 'MAC')
mchr = Selenium::WebDriver::Remote::Capabilities.chrome(:takes_screenshot => true, :platform => 'MAC')

browsers = [ wie8, wff6, wchr, lff3, lff6, lff7, lchr, lopr,  mff6, mchr ]

browsers.peach do |browser|
  begin
    driver = Selenium::WebDriver.for(
    	:remote,
    	:url => hub,
    	:desired_capabilities => browser
    )

    puts "Requested properties: #{driver.capabilities.browser_name.capitalize}(#{driver.capabilities.version}) on #{driver.capabilities.platform.capitalize}."
    driver.get "http://www.bmivisualizer.com"
    driver.save_screenshot("./#{driver.capabilities.platform}-#{driver.browser}(#{driver.capabilities.version}).png")
		driver.quit
  rescue
		puts "Problem with #{browser.browser_name} (#{browser.browser.version}) on #{browser.platform}."
    next
  end
end
