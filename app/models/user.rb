class User < ActiveRecord::Base
	
	has_secure_password

	validates_presence_of :name, :on => :create, :notice => "Need a name"
	validates_confirmation_of :password, :notice => "Need a password"
  	validates_presence_of :password, :on => :create, :notice => "Need a password"
	validates_presence_of :email, :notice => "Please include email"
	validates_uniqueness_of :email, :notice => "Email already taken"
	validates_presence_of :username, :notice => "Please include username"
	validates_uniqueness_of :username, :notice => "Username already taken"

	has_many :calendars, :dependent => :destroy
	has_many :events

	attr_writer :smart_query_set

	def smart_query_set
		@smart_query = true
	end

end
