require 'twiliolib'

API_VERSION = '2008-08-01'
ACCOUNT_SID = 'AC725017e91ee8b50b0cb223e4e3fe961a'
ACCOUNT_TOKEN = 'f34e94b9d465831a88718fce57c91142'
CALLER_ID = '2062299142'

class SaxController < ActionController::Base
  def index
    render action_name + '.xml.erb'
  end

  def call
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)

    resp = account.request(
      "/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
      'POST',
      {
	'Caller' => CALLER_ID,
	'Called' => params[:victim],
	'Url' => url_for(:action => 'index')
      })
    return head :bad_request unless resp.kind_of? Net::HTTPSuccess

    render :xml => resp.body
  end
end
