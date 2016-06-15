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
        #Guarda la informacion del usaurio en una variable de session
		session["devise.auth"] = request.env["omniauth.auth"]
        
        #llama a la vista edit de users/omniauth_callbaks
        #por si el usuario no cuanta con su email
		render :edit
	end
	
	#Madejando el error cuando el usuario da cancelar el permito con facebook
	def failure
	    #Lo direcciona al login con el error de facebook diciendo el motivo
		redirect_to new_user_session_path, notice: "No pudimos loguearte. Error: #{params[:error_description]}. Motivo: #{params[:error_reason]}"
	end
	
	#Metodo para operar los datos para completar el login
	def custom_sign_up
	    #Intancia al modelo User y llama al metodo from_omniauth y pasa los
	    #parametros que requiere
		@user = User.from_omniauth(session["devise.auth"])
		#Pregunta si existen los parametros
		if @user.update(user_params)
		    
			sign_in_and_redirect @user, event: :authentication
		else
			render :edit
		end
	end
	
	#Pametros fuertes	
    private
        #Metodo para actulizar o completar el login
		def user_params
			#Strong Params
			#Require de una table user con un nombre, nombre de usuario y el email
			#No hay mas parametros en el formulario rechaza la custom_sign_up
			params.require(:user).permit(:name,:username,:email)
		end
end