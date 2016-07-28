module NotificationsHelper

	def render_notifications(notifications)
		notifications.map do |notification|
			#un parcial para cada uno de los item_type
			render partial:"notifications/#{notification.item_type.downcase}", locals:{notification: notification}
			#{}"Esta es una notificaion de tipo" + notification.item_type
		end.join(" | ").html_safe
		
	end
end
=begin
Map
Es devuelve un arreglo
[1,2,3,4,5,6].map {|numero° numero + 1	}
[2,3,4,5,6,7]
 join lo convierte ne cadena
rescue Exception => e
	
=end