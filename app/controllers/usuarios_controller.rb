class UsuariosController < ApplicationController
    #Declara el el filtro con un metodo para buscar el usuario
    #que se quiere mostror o actulizar
    before_action :set_user

    def show
        
    end
    
    def update
        
    end
    
    private
        #Intancia un objeto de la clase o modelo
        #user y busca por el id
        def set_user
            @user = User.find(params[:id])
        end
end