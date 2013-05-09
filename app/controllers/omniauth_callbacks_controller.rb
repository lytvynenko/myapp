class OmniauthCallbacksController < ApplicationController
	def all
		logger.debug request.env["omniauth.auth"]
		user = User.from_omniauth(request.env["omniauth.auth"])
		if user.persisted?
			sign_in_and_redirect user
		else
			session["devise.user_attributes"] = user.attributes
			redirect_to new_user_registration_url
		end	
	end


alias_method :twitter, :all
alias_method :facebook, :all
alias_method :google, :all

	# def facebook

 #    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

 #    if @user.persisted?
 #      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
 #      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
 #    else
 #      session["devise.facebook_data"] = request.env["omniauth.auth"]
 #   	  session["devise.user_attributes"] = user.attributes
 #      redirect_to new_user_registration_url
 #    end
 #  end

# def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
#   user = User.where(:provider => auth.provider, :uid => auth.uid).first
#   unless user
#     user = User.create(name:auth.extra.raw_info.name,
#                          provider:auth.provider,
#                          uid:auth.uid,
#                          email:auth.info.email,
#                          password:Devise.friendly_token[0,20]
#                          )
#   end
#   user
# end

# 	def failure
# 		super
# 	end	
	
end
