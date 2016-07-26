# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class PostChannel < ApplicationCable::Channel
  def subscribed
    #Canal la cual se suscriben los usuarios
    #dependiendo de sus amigos
    stream_from "posts_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #def echo(data)
    # Metodo de ejemplo se hace el streaming a la conecion que se dara
    # en este caso stream_from "demo" hace la conecion a t
  #	ActionCable.server.broadcast "demo", {servidor: "Holaaa"}
  #end
end
