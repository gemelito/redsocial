class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #Para que implemente del metodo set_layout
  layout :set_layout

  #Hace el render del aplication
  protected
	  def set_layout
	  	"application"
	  end
end
