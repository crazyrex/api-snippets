# Get twilio-ruby from twilio.com/docs/ruby/install
require 'rubygems' # This line not needed for ruby > 1.8
require 'twilio-ruby'

# Get your Auth Token from https://www.twilio.com/console
auth_token = '12345'
validator = Twilio::Util::RequestValidator.new(auth_token)

url = 'https://mycompany.com/myapp.php?foo=1&bar=2'
params = {
  'CallSid' => 'CA1234567890ABCDE',
  'Caller'  => '+14158675310',
  'Digits'  => '1234',
  'From'    => '+14158675310',
  'To'      => '+18005551212'
}
# The X-Twilio-Signature header attached to the request
twilio_signature = 'GvWf1cFY/Q7PnoempGyD5oXAezc='

print(validator.validate(url, params, twilio_signature))
