class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_filter :set_current_user
  protect_from_forgery

  helper_method :current_user



end
