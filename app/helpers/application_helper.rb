module ApplicationHelper

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def set_current_user
    @current_user = current_user
  end

  def read_more_link_to path
    link_to 'Read more', path, class: "icon icon-arrow-right button"

  end

end
