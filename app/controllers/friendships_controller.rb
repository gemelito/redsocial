class FriendshipsController < ApplicationController
    #ante que entre en la accion primero para a buscar al amigo
    before_action :find_friend,except: [:index,:update]
	before_action :find_friendship, only: [:update]
    
    #Para la ruta index la cual muestra todas las solicitudes de amigistas que tiene y las
    #denegadas y para aceptar o denegar
    def index
    	#Variable de clase para gustar a las amistades pendientes
    	#atravez del metodo pendinf for user del model friendship para un parametro
    	@pending_friendships = current_user.followers.pending.decorate
		@accepted_friendships = current_user.followers.active.decorate
		@pending_requests = current_user.friendships.decorate
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
	
	def update
		if params[:status] == "1"
			@friendship.accepted!
		elsif params[:status] == "0"
			@friendship.rejected!
		end
		respond_to do |format|
			format.html{ redirect_to friendships_path }
		end
	end
    
    private
        #metodo para buscar al usuario atravez del id
        def find_friend
			@friend = User.find(params[:friend_id])
		end
		def find_friendship
			@friendship = Friendship.find(params[:id])
		end
        
end