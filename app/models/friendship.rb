class Friendship < ApplicationRecord
  include AASM
  belongs_to :user
  #Pasamos la clase la cual va a mapiar para hacer referencia con el mismo usuario
  #ya que el friend es un usuario
  belongs_to :friend, class_name: "User"
  #Validamos que solo una vez que puede tener amistad con algun usuario
  #Pasamos un rol al id de la tabla friend
  validates :user_id, uniqueness:{ scope: :friend_id,message: "Amistad duplicada"}
  
  #Resive al usuario a al amigo para ver si son amigos
  #aqui se realiza la query
  def self.friends?(user,friend)
    #Retorna verdad si el usuarios es igual al amigo
    return true if user == friend
    #realiza la busqueda preguntando que si el yo es amigo del edwin
    #o si el amigo es edwin es mi amigo, esto retorna verdad si hubo alguno
    Friendship.where(user:user,friend:friend)
              .or(Friendship.where(user:friend,friend:user))
              .any?
  end
  
  #Metodo que resive un parametro que es el usaurio
  def self.pending_for_user(user)
    #Cuentra las amistades tentiendes por el estatus de la maquina de estados
    #del usuario que solicita lista de amistades
    Friendship.pending.where(friend: user)
  end
  
  def self.pending_for_user(user)
    Friendship.pending.where(friend: user)
  end

  def self.accepted_for_user(user)
    Friendship.active.where(friend: user)
  end
  
  #Definimos una maquina de estado y pasamos un bloque de status
  aasm column: "status" do
    #Amistad pendiente para la relacion
  	state :pending, initial: true
  	#Amistad aceptada
  	state :active
  	#Rechazo
  	state :denied

    #Declamos eventos para cuando enviemos una amista
    #cuando fue a aceptado
  	event :accepted do
  	  #utilizamos las transiciones de pendiente a actimo
  	  #cuando la amistas paso de envio a aceptado
  		transitions from: [:pending], to: [:active]
  	end

  	event :rejected do
  	  #cuando este pendiente o activo te bloquedo o rechazado
  		transitions from: [:pending,:active], to: [:denied]
  	end

  end
end
