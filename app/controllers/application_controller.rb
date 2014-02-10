class ApplicationController < ActionController::Base

  before_filter :set_current_user
  protect_from_forgery

  helper_method :current_user



end
