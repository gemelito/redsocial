module Notificable
	#este modulo se usa en post.rb y friendship.rb
	#trabaja con concern.
	extend ActiveSupport::Concern
	##ejecuta el envio de las notificaciones
	#aquien lo tienen
	included do
		#relacion muchos a muchos con relacion pymorphic
		has_many :notifications, as: :item
		after_create :send_notification_to_users
	end

	def send_notification_to_users
		
	end

end
	#Esto seria la notificacion
	#item:id = 10
	#item:type = "post"
	#item:user_id = 5