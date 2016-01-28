class UsersController < ApplicationController

  require 'signet/oauth_2/client'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  before_filter :authorize, :only => [:show, :redirect, :callback, :edit, :update, :destroy]

  def redirect
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: 'http://localhost:3000/oauth2callback'
    })

    redirect_to client.authorization_uri.to_s
  end

  def callback
    @user = current_user
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: url_for(:action => :callback),
      code: params[:code]
    })
    response = client.fetch_access_token!
    if Calendar.find_by_user_id(@user.id).nil?
      c = Calendar.new
      c.user_id = current_user.id
      c.code = response['access_token']
      c.save
    end
    #session[:access_token] = response['access_token']

    redirect_to '/events/create'
  end

  def show
    @user = current_user
    @events = Event.where(user_id: current_user.id)
  end

  def new
    if current_user
      redirect_to '/'
    end
    @user = User.new
  end

  def index
    
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def edit
    @user = User.find(current_user.id)
    @no_events = Event.where(user_id: @user.id).empty?
  end

  def update
    @user = User.find(current_user.id)
    user_params = params.require(:user).permit(:name,:email)
    if @user.update_attributes(user_params)
      flash[:notice] = "Updated!"
      redirect_to "/"
    else 
      flash[:notice] = @user.errors.map{|k,v| "#{k} #{v}".capitalize}
      redirect_to "/"
    end
  end

  def destroy
    if @user.id == current_user.id
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to '/signup'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
