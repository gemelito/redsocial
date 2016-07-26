# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
#Todo lo que se ponga en esta clase estara disponible para todos las nuevas websockets que se conecten
module ApplicationCable
  class Connection < ActionCable::Connection::Base

  	#Es un metodo para intentificar a los usuarios
  	#que se conecten al canal
  	identified_by :current_user

  	#Metodo que se ejecuta cuando una nueva webs se conecta
  	def connect
  		#Se sigue la convencion para la identificacion del usuario
  		#y buscamos alusuario que se intenta conectar
  		self.current_user = find_user
  	end

  	def find_user
  		user_id = cookies.signed["user.id"]
  		#Busca al usuario atravez de una cookie l cual no existe pero se crea en
  		#config/initializers/warden_hooks.rb
  		current_user = User.find_by(id:user_id)
  		
  		#si existe el usuario con la misma cokkie
  		#retorna el usuario
  		if current_user
  			current_user
  		else
  			reject_unauthorized_connection
  		end
  	end

  end
end
