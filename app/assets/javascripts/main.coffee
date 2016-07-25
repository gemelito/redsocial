# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.snack = (options)->
	document.querySelector("#global-snackbar")
					.MaterialSnackbar.showSnackbar(options)

window.loading = false

$(document).on "page:load page:fetch ready", ()->
	$(".best_in_place").best_in_place()
	$(".mdl-layout").scroll ->
		#Cargamos publicaciones cuando el usuario ya casi llego al
		#final de la pantall. Para eso utilizamos una funcion que scrollTop
		#que nos da que tan lejos del top se encuentra
		#Obtenemos la url de will_paginate. loading para saber si ya hay una cargar De las publicaciones
		if !window.loading && $(".mdl-layout").scrollTop() > $(document).height() - 100
			#Es una forma mas de trabajar con ajax -> metodo ->url -> get
			#La cual enviamos informacion con data type y decir la url Para
			#mandar la informacion
			#Hay que responder con ajax para mostrar los posts
			#En main/home.js.coffe
			window.loading = true
			url = $(".next_page").attr("href")
			$.getScript url if url
			