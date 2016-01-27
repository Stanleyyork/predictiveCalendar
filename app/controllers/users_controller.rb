class UsersController < ApplicationController

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  def new
    if current_user
      redirect_to '/'
    end
    @user = User.new
  end

  def index
    @events = Calendar.calCall.list_events('primary')
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
