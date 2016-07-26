App.post = App.cable.subscriptions.create "PostChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server
    # Todo lo que se quiera mostras pasata por este metodo
  received: (data) ->
    # console.log data
    # Called when there's incoming data on the websocket for this channel
    # Ejemplo de como funciona el actioncable
    # Llama al metodo echo y le pasa el parametro que solicita el mismo
    # el perform ase referencia al metodo.
  	if data.action == "new_post"
      $("#posts .data").prepend(data.message)
  echo: ()->
  	@perform "echo", {hola: "mundo"}