class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  layout :layout_by_resource

  protected
    def layout_by_resource
      devise_controller? ? 'login' : 'application'
    end
end
