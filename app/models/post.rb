# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

#Relacion 1:N
#Un post solo puede tener un usuario y se representa con => belongs_to
#Un usuario puede tener muchos posts y se representa con => has_many
class Post < ApplicationRecord
	include Notificable
  belongs_to :user
  scope :nuevos, ->{ order("created_at desc") }
  #Creamos un metodo para hacer el striming a todos los
  #coenectados en el canal del usuario que publicara
  after_create :send_to_action_cable

  def self.all_for_user(user)
		Post.where(user_id: user.id)
				.or( Post.where(user_id: user.friend_ids))
				.or( Post.where(user_id: user.user_ids))
	end

	def user_ids
		#Devolvemos los id de los amigos del usuarios
		self.user.friend_ids + self.user.user_ids
	end

	private
		#Metodo que incluye la libreria del actioncable y se conecta
		#al canal demo y la cual es el encargado de mandar a todos los conectados
		#la publicacion que realiza un usuario y responde con una action desde el controllador
		def send_to_action_cable
			data = {message: to_html,action:"new_post"}
			self.user.friend_ids.each do |friend_id|
				#"posts_#{friend_id}" hace el broacating a todos los amigos del usuarios
				#quien realiza la publicacion
				ActionCable.server.broadcast "posts_#{friend_id}", data
			end

			self.user.user_ids.each do |friend_id|
				ActionCable.server.broadcast "posts_#{friend_id}", data
			end
			
		end

		def to_html
			ApplicationController.renderer.render(partial: "posts/post", locals: { post: self })
		end

end
