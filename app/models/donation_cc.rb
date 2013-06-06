class DonationCC < ActiveResource::Base
   headers['JG_APPLICATIONKEY']  = '7692fb3f-da80-49a4-bfe4-99f18b4dfc54'
   headers['JG_SECURITYTOKEN'] = '4a194e2e-c55d-43af-8e14-23ced7adf168'
   self.site = "http://usapisandbox.fgdev.net/donation/creditcard"
end