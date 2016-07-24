class MainController < ApplicationController
  
  def home
    #Esta jquery trae todas las nuevas publicacion
    @post = Post.new
    #Esta jquery trae todas las publicaciones de los amigos en comun
    #y con un numero de publicaiones. Esta utilizando el metodo del will_pagine
    #params para pasarle el numero de pagina page?=1,2,3,4 y el numero de publicaciones
    @posts = Post.all_for_user(current_user).nuevos.paginate(page:params[:page],per_page:1)
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
