#!/usr/bin/ruby
#!/Users/jon/.rvm/rubies/ruby-1.9.2-head/bin/ruby

require 'rubygems'
require 'selenium-webdriver'
require 'awesome_print'
require 'yaml'

hubhost = "scalzi.is.localnet"
hub = "http://#{hubhost}:4444/wd/hub"
infile = ARGV[0]
urls = []
timestamp = Time.now.strftime("%d-%B-%Y-%H%M")
resultsdir = "./results/#{timestamp}"
system ("mkdir -p #{resultsdir}")
index = File.new("./#{resultsdir}/index.html", "w")

# Grab list of urls from yaml!
def get_targets(file)
	File.open(file) { |file| YAML.load(file) }
end

# Old method of grabbing lines from flatfile
#File.open(targets, 'r') do |f|
##	urls = f.readlines
#end

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

# Chromedriver is subject to an annoying bug in v14, can't take remote screenshots anymore.
browsers = [ wie8, wie9, wff6, lff3, lff6, lff7, lopr, mff6, ]
#browsers = [ wie9 ]

# Set up baseurl and list of urls to test
targets = get_targets(infile)
project = targets['project']
baseurl = targets['base']
urls = targets['urls']

index.syswrite("<html><head><link href=http://#{hubhost}/assets/festival.css rel=stylesheet type=text/css /><title>Festival: Results for #{timestamp}</title></head><body><div class=header><img src=http://#{hubhost}/assets/festival.png />")
index.syswrite("<h2>Results for #{project}</h2>")

urls.each do |name,url|
	fullurl = baseurl + url
	puts "Testing: #{fullurl}"
end

# Don't forget to close your tags!
index.syswrite("</div>")

urls.each do |name,url| # TODO: More Parallelizin' but not too much - early testing with peach led to a messed up grid

	fullurl = baseurl + url
	index.syswrite("<div class=url><h3><a href='#{fullurl}'>#{name}</a></h3></div>")
  index.syswrite("<div class=wrapper><div class=spacer></br></div>")
	puts "Testing target url: #{fullurl}"

	browsers.each do |browser|
		begin

		driver = Selenium::WebDriver.for(
			:remote,
			:url => hub,
			:desired_capabilities => browser
		)

			#TODO: This is fugly, sort it out!

			index.syswrite("<div class=screenie><p>#{driver.capabilities.browser_name}(#{driver.capabilities.version}) on #{driver.capabilities.platform}</p><a href='./#{name}/#{driver.capabilities.platform}/#{driver.capabilities.browser_name}(#{driver.capabilities.version}).png'><img src='./#{name}/#{driver.capabilities.platform}/#{driver.capabilities.browser_name}(#{driver.capabilities.version}).png' width=300px border=2px></a></div>")
			puts "Requested properties: #{driver.capabilities.browser_name}(#{driver.capabilities.version}) on #{driver.capabilities.platform}."
 			driver.get fullurl
			if File.exists?("#{resultsdir}/#{name}") == false
        FileUtils.mkdir("#{resultsdir}/#{name}")
      end
			if File.exists?("#{resultsdir}/#{name}/#{driver.capabilities.platform}") == false
				FileUtils.mkdir("#{resultsdir}/#{name}/#{driver.capabilities.platform}")
			end
			driver.save_screenshot("./#{resultsdir}/#{name}/#{driver.capabilities.platform}/#{driver.capabilities.browser_name}(#{driver.capabilities.version}).png")
			driver.quit

		rescue => ex  #TODO: Collect all these and stick them at the end of the page, or display them more elegantly than twattily inline
			puts "#{ex.backtrace}: #{ex.message} (#{ex.class})"
			index.syswrite("<div class='error'>There was an error processing this browser/OS Combination: #{ex.backtrace}: #{ex.message} (#{ex.class})</div>")

 	 	next

		end
		index.syswrite("<div class=spacer><br></div></div>")

	end

end

# Clean up index.html file.
index.syswrite("</div></html>")
index.close
puts "Test results available at: http://#{hubhost}:8080/job/bmivisualizer/ws/results/#{timestamp}/"
