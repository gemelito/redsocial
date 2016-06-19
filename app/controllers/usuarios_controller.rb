class UsuariosController < ApplicationController
    #Declara el el filtro con un metodo para buscar el usuario
    #que se quiere mostror o actulizar
    #Como primero se ejecuta el set_user
    #ya se tiene acceso a la instancia @user en show,update
    before_action :set_user
    before_action :authenticate_user!,only: [:update]
	before_action :authenticate_owner!,only: [:update]	

    def show
        
    end
    
    def update
        #Paramos un bloque de codigo para responder a la hora que el usuario
        #quiera actulizar su informacion y respondemos de dos formas json y html
       respond_to do |format|
			if @user.update(user_params)
				format.html{ redirect_to @user}
				format.json{ render :show, status: :created, location: @user }
				format.js
			else
				format.html{redirect_to @user,notice:@user.errors.full_messages}
				format.json{ render json: @user.errors }
			end
		end
    end

    private
        #Intancia un objeto de la clase o modelo
        #user y busca por el id
        def set_user
            @user = User.find(params[:id])
        end
        
         def authenticate_owner!
			if current_user != @user
				redirect_to root_path, notice: "No estás autorizado",status: :unauthorized
			end
		end
        
        #Metodo para decir que solo estos campos
        #pueden es utilizados a la otra de utilizar el metodo update
        def user_params
            #:user es un hash que contiene los valores o parametros que se quieren utilizar
            #en este caso son los siguente  permit(:email,:username:,:name,:last_name,:bio)
            params.require(:user).permit(:email,:username,:name,:lastname,:bio,:avatar,:cover)
        end
        
end