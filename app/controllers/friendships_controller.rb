class FriendshipsController < ApplicationController
    #ante que entre en la accion primero para a buscar al amigo
    before_action :find_friend
   
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