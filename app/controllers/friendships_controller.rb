class FriendshipsController < ApplicationController
    #ante que entre en la accion primero para a buscar al amigo
    before_action :find_friend, except: [:index]
    
    #Para la ruta index la cual muestra todas las solicitudes de amigistas que tiene y las
    #denegadas y para aceptar o denegar
    def index
    	#Variable de clase para gustar a las amistades pendientes
    	#atravez del metodo pendinf for user del model friendship para un parametro
    	@pending_friendships = Friendship.pending_for_user(current_user)
    end
   
    def create
		friendship = Friendship.new(user: current_user, friend: @friend)
		respond_to do |format|
			if friendship.save
				format.html { redirect_to @friend }
				format.js
			else
				format.html {redirect_to @friend, notice: "Error con la solicitud de amistad"}
				format.js
			end
		end
	end	
    
    private
        #metodo para buscar al usuario atravez del id
        def find_friend
			@friend = User.find(params[:friend_id])
		end
		
        def find_model
            @model = Friendships.find(params[:id]) if params[:id]
        end
        
end