# Get twilio-ruby from twilio.com/docs/ruby/install
require 'twilio-ruby'

# Get your Account SID and Auth Token from twilio.com/console
account_sid = 'ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
auth_token = 'your_auth_token'

client = Twilio::REST::Client.new(account_sid, auth_token)

sim = client.wireless
            .sims('DEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA')
            .update(
              status: 'active',
              callback_url: 'https://sim-manager.mycompany.com/sim-update-callback/AliceSmithSmartMeter',
              callback_method: 'POST'
            )

puts sim
