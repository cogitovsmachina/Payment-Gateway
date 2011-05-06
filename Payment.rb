require 'rubygems'
require 'sinatra'
require 'twiliolib'


ACCOUNT_SID = 'AC960db3ae4c368e1a6be0fe425af45aab'
ACCOUNT_TOKEN = '622a8488bfc1f4855698d424d9b5ffdd'

# version of the Twilio REST API to use
API_VERSION = '2010-04-01'

# base URL of this application
BASE_URL = "http://woojin.heroku.com"

CALLER_ID = '415237-4431'

class Sms
  def self.normalize_number(n)
    "+1" + n.delete(' (\-)') if n
  end
  
  def self.send(to_phone_number, body)
    d = {
      'From' => CALLER_ID,
      'To' => Sms.normalize_number(to_phone_number),
      'Body' => "You sent: #{params[:body]} !"
    }
  
    begin
      account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
      url = "/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages"
      puts url
      puts d.inspect
      resp = account.request(url, 'POST', d)
      resp.error! unless resp.kind_of? Net::HTTPSuccess
      return true
    rescue StandardError => bang
      # todo: log it somewhere!
      puts bang.inspect
      return false
    end    
  end
end

get '/Sms' do
  content_type 'text/xml'
  "<Response>
  <Sms>
  This is a test
  </Sms>
  </Response>"
end 
  

post '/' do
  content_type 'text/xml'
  "<Response>
  <Sms>
  This is a test #{resp}
  </Sms>
  </Response>"
end   

