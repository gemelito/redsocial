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
		#este metodo sirve para no romper la aplicacion
		#y para preguntar si existe algun post con un user_id
		#users_id es un metodo que se ejecuta en friendship y post
		if self.respond_to? :user_ids
			#aqui existe un problema al crecer el envio de las notificaciones
			#tardaria mucho enviar a los usuarios la notificacion.
			#Una forma sencilla de controlar eso es utilizando JOB
			#lo manda de manera de async
			#hace trabaja primer creamos el post
			#2. creamos un tragaja para las notificaciones (JOB)
			#3. responder con el mismo post, mostrarlo
			#4. enviar las notificaciones

			#llama al job y el pasa un parametro la cual se
			#pasa un tiempo para ejecutar el job
			NotificationSenderJob.perform_later(self)
		end
	end

end
	#Esto seria la notificacion
	#item:id = 10
	#item:type = "post"
	#item:user_id = 5