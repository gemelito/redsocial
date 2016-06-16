class MainController < ApplicationController
  def home
    @post = Post.new
  end
  
  def unregistered
  end
  
  #Proteje al metodo set
  protected
    #llam al metodo de la clase padre para mandar a llamar
    #a landing y la vista es unregistered
    #si es la retorna y si no pues sigue la ejecuion del codigo
    #en este caso trae a la vista de application.html que
    #se encuenta en applica_controller
	  def set_layout
	  	return "landing" if action_name == "unregistered"
	  	super
	  end
	  
end
