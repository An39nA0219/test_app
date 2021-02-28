class ApplicationController < ActionController::API

  include ActionController::Cookies

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    current_user
    return if @current_user
    render_unauthorized
  end

  def require_logout
    current_user
    return unless @current_user
    render_unauthorized
  end


  # 400 Bad Request
  def render_bad_request
    render status: 400, json: { status: 400, message: 'Bad Request' }
  end

  # 401 Unauthorized
  def render_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def render_not_found(class_name = 'page')
    render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
  end

  # 409 Conflict
  def render_conflict(class_name)
    render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def render_internal_server_error
    render status: 500, json: { status: 500, message: 'Internal Server Error' }
  end

end
