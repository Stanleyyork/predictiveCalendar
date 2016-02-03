class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def homepage
    render template: "layouts/homepage.html.erb"
  end

  def about

    @user = User.find_by_email("stanleyyork@gmail.com")
    attendees = [100, 90, 55, 50, 30, 25, 25, 20, 20, 18, 15, 12]
    events_collabs_array = attendees.each_with_index.map{|x,i| ["Stanley", "J. Harbaugh-#{i}", x]}
    @events_collabs_sankey_small = GoogleChart.new.sankey(events_collabs_array[1..15],400,325)
    @events_collabs_sankey_med = GoogleChart.new.sankey(events_collabs_array[1..15],400,650)
    render template: "layouts/about.html.erb"
  end
  
end
