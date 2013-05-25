class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :set_access_control_headers

  def set_access_control_headers
#    headers['Access-Control-Allow-Origin'] = 'http://doubleheart.us'
#    headers['Access-Control-Request-Method'] = 'http://doubleheart.us'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'

  end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end
end
