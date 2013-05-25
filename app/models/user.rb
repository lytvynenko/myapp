class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,:token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :provider, :uid,:oauth_token, :profile_attributes
  has_one :profile
  accepts_nested_attributes_for :profile
 
  validates_presence_of :username
  # attr_accessible :title, :body

  def self.from_omniauth(auth)
    puts auth
  	where(auth.slice(:provider,:uid)).first_or_create do |user|
  		user.provider = auth.provider
  		user.uid = auth.uid
  		user.username = auth.info.name
  		user.email = auth.info.email
      user.oauth_token =auth.credentials.token
#      user.save! 
  	end
  end	

  def facebook
    @facebook ||=Koala::Facebook::API::new(oauth_token)
  end 

  def self.new_with_session(params,session)
  	if session["devise.user_attributes"]
  		new(session["devise.user_attributes"],without_protection:true) do |user|
  			user.attributes = params
  			user.valid?
  		end	
  	else
  		super
  	end		
  end

  def password_required?
  	super && provider.blank?
  end	

  def update_with_password(params,*options)
  	if encrypted_password.blank?
  		update_attributes(params,*options)
  	else
  		super
  	end		
  end	

  def create
    @profile = current_user.profile.first_or_create
  end 

end
