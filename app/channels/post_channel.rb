# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class PostChannel < ApplicationCable::Channel
  def subscribed
    stream_from "demo"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def echo(data)
    # Metodo de ejemplo se hace el streaming a la conecion que se dara
    # en este caso stream_from "demo" hace la conecion a t
  	ActionCable.server.broadcast "demo", {servidor: "Holaaa"}
  end
end
