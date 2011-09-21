#!/usr/bin/ruby
#!/Users/jon/.rvm/rubies/ruby-1.9.2-head/bin/ruby

require 'rubygems'
require 'selenium-webdriver'
require 'awesome_print'
require 'peach'

hub = 'http://scalzi.is.localnet:4444/wd/hub'
targets = ARGV
timestamp = Time.now.strftime("%d-%B-%Y-%H%M")
resultsdir = "./results/#{timestamp}"
system ("mkdir -p #{resultsdir}")
index = File.new("./#{resultsdir}/index.html", "w")


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

browsers = [ wie8, wie9, wff6, wchr, lff3, lff6, lff7, lchr, lopr,  mff6, mchr ]

index.syswrite("<html><head><title>Festival: Results for #{timestamp}</title></head><img src=../../../lib/img/festival.png/>")
index.syswrite("<h2>Urls under test:</h2> <p> <ul>")
targets.each do |target|
	index.syswrite("<li><a href=#{target}>#{target}</a></li>")
end

targets.each do |target| # TODO: More Parallelizin' but not too much - maybe see about queue requests to SGrid

	index.syswrite("<h3>#{target}</h3>")
	puts "Testing target url: #{target}"

	browsers.peach do |browser|
		begin

		driver = Selenium::WebDriver.for(
			:remote,
			:url => hub,
			:desired_capabilities => browser
		)
			index.syswrite("<p>#{driver.capabilities.browser_name}(#{driver.capabilities.version}) on #{driver.capabilities.platform}</p><a href='./#{target}/#{driver.capabilities.platform}/#{driver.capabilities.browser_name}(#{driver.capabilities.version}).png'><img src='./#{target}/#{driver.capabilities.platform}/#{driver.capabilities.browser_name}(#{driver.capabilities.version}).png' width=300px border=2px></a>")
			puts "Requested properties: #{driver.capabilities.browser_name}(#{driver.capabilities.version}) on #{driver.capabilities.platform}."
 			driver.get target
			if File.exists?("#{resultsdir}/#{target}") == false
        FileUtils.mkdir("#{resultsdir}/#{target}")
      end
			if File.exists?("#{resultsdir}/#{target}/#{driver.capabilities.platform}") == false
				FileUtils.mkdir("#{resultsdir}/#{target}/#{driver.capabilities.platform}")
			end
			driver.save_screenshot("./#{resultsdir}/#{driver.capabilities.platform}/#{driver.capabilities.browser_name}(#{driver.capabilities.version}).png")
			driver.quit

		rescue => ex
			puts "#{ex.backtrace}: #{ex.message} (#{ex.class})"

 	 	next

		end

	end

end

# Clean up index.html file.
index.syswrite("</html>")
index.close
