#Metodo definido por devise la cual pasa tres parametros
#usuario, informacion de la aute y las opciones del evento
#hook es un evento despues de un evento
Warden::Manager.after_set_user do |user,auth,opts|
	#nombre la cookie para intenficicar la informacion, en este caso
	#debe ser igual a la cookie que se indigo en connect
	auth.cookies.signed["user.id"] = user.id
	#Toma el campo de expiracion despues de logearse y le agrega 30m
	auth.cookies.signed["user.expires_at"] = 30.minutes.from_now
end

#Metodo para limpiar despues de logearse
Warden::Manager.before_logout do |user,auth,opts|
	auth.cookies.signed["user.id"] = nil
	auth.cookies.signed["user.expires_at"] = nil
end