class User < ActiveRecord::Base
	has_secure_password

	validates_confirmation_of :password
  	validates_presence_of :password, :on => :create

	validates_presence_of :email, :notice => "Please include email"
	validates_uniqueness_of :email, :notice => "Email already taken"
	validates :username, length: {minimum: 3, maximum: 15}, :uniqueness => { :case_sensitive => false},
	  format: {
	    with: /\A[a-zA-Z0-9_-]+\z/,
	    message: 'Must be formatted correctly (no spaces)'
	  }
end
