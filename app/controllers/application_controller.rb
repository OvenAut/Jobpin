class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :show_agent
  
  def show_agent
  puts agent = request.headers["HTTP_USER_AGENT"].downcase
  end
end
