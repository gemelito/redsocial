class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #Para que implemente del metodo set_layout
  layout :set_layout
  
  #PAra permitir el registro del username si el controlador es devise_controller
  before_action :configurar_strong_params, if: :devise_controller?


  #Hace el render del aplication
  protected
	  def set_layout
	  	"application"
	  end
	  
	  #metodo para declarar que campos dejar menar devise, en este caso solo username
	  def configurar_strong_params
	  	devise_parameter_sanitizer.permit(:sign_up,keys: [:username])
	  end
end
