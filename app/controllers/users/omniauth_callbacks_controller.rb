class Users::OmniauthCallbacksController < ApplicationController

	def facebook
	    #Intancia al modelo User y llama al metodo from_omniauth y pasa los
	    #parametros que requiere
		@user = User.from_omniauth(request.env["omniauth.auth"])
        #Pregunta si el usuarios existe en la base de datos
		if @user.persisted?
		    #Para recordarle  a la app que no require login otra vez
			@user.remember_me = true
			#Redirecciona al usaurio al home
			sign_in_and_redirect @user, event: :authentication
			return
		end

		session["devise.auth"] = request.env["omniauth.auth"]

		render :edit
	end

end