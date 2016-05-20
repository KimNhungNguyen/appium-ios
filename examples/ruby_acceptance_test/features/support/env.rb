require 'appium_lib'
require 'rspec/expectations'
require 'page-object'
require 'test/unit/assertions'

# caps = Appium.load_appium_txt file: File.expand_path('../', __FILE__), verbose: true

APP_PATH = '../../apps/TestApp/build/release-iphonesimulator/TestApp.app'

max_wait_in_seconds = 10

World PageObject::PageFactory
World Test::Unit::Assertions  # need this for 'assert' method

SAUCE_USERNAME = ENV['nhung_nguyen']
SAUCE_ACCESS_KEY = ENV['e6199f20-a2cb-436e-8158-51ad8bbbac6c']

desired_caps = 
{ caps:       
	{
    	platformName:  'iOS',
    	versionNumber: '9.3',
	    deviceName:    'iPhone 6',
	    app:           APP_PATH
	},
	appium_lib: {
		sauce_username: nil,
		sauce_access_key:  nil
    }
}

def auth_details
	un = SAUCE_USERNAME
	pw = SAUCE_ACCESS_KEY
	unless un && pw
  		STDERR.puts <<-EOF
      	Your SAUCE_USERNAME or SAUCE_ACCESS_KEY environment variables 
      	are empty or missing.
      
      	You need to set these values to your Sauce Labs username and access
      	key, respectively.

      	If you don't have a Sauce Labs account, you can get one for free at
      	http://www.saucelabs.com/signup
    	EOF
    	exit
  	end
  	return "#{un}:#{pw}"
end

def server_url
	"http://#{auth_details}@ondemand.saucelabs.com:80/wd/hub"
end

def rest_jobs_url
  "https://#{auth_details}@saucelabs.com/rest/v1/#{SAUCE_USERNAME}/jobs"
end

# Because WebDriver doesn't have the concept of test failure, use the Sauce
# Labs REST API to record job success or failure
def update_job_success(job_id, success)
  RestClient.put "#{rest_jobs_url}/#{job_id}", { 'passed' => success }.to_json, :content_type => :json
end


def start_appium
	system "appium --log-level error &"
end

def shutdown_appium
	process = `ps -e | grep 'appium.*error$' | awk '{print $1}'`
	if process.length > 0
		system "kill #{process}"
	end
end

Before do
	if !$global_setup
		start_appium
		$global_setup = true
		sleep 5
	end
	@driver = Appium::Driver.new(desired_caps)

  # need to type @browser to be able to use PageObject (OMG!!!), just '@driver.start_driver' doesn't work
	@browser = @driver.start_driver
	@driver.set_wait max_wait_in_seconds
end

After do
  @driver.driver_quit
end

at_exit do
  shutdown_appium
end


