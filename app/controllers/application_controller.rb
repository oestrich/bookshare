class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to "/"
  end
end
