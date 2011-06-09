require 'rubygems'
require 'sinatra'
require 'twiliolib'

# Twilio REST API version
API_VERSION = '2010-04-01'

# Twilio AccountSid and AuthToken
ACCOUNT_SID = 'AC960db3ae4c368e1a6be0fe425af45aab'
ACCOUNT_TOKEN = '622a8488bfc1f4855698d424d9b5ffdd'

# Outgoing Caller ID previously validated with Twilio
CALLER_ID = '4152374431';

# Create a Twilio REST account object using your Twilio account ID and token
account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
d = {
    'From' => CALLER_ID,
#    'To' => '7073975714', 
     'To' => '+5215521022584', 
    'Body' => 'Twilio+Sinatra+Heroku = world domination!'
}
resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages",
    'POST', d)
resp.error! unless resp.kind_of? Net::HTTPSuccess
puts "code: %s\nbody: %s" % [resp.code, resp.body]

get '/Sms' do
  content_type 'text/xml'
  "<Response>
  <Sms>
  This is a test
  </Sms>
  </Response>"
end 


get '/' do
    "It Works!"
end




