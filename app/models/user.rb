class User < ActiveRecord::Base
	has_secure_password

	validates_confirmation_of :password, :notice => "Need a password"
  	validates_presence_of :password, :on => :create, :notice => "Need a password"

	validates_presence_of :email, :notice => "Please include email"
	validates_uniqueness_of :email, :notice => "Email already taken"

end
