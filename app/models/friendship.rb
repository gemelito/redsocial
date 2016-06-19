class Friendship < ApplicationRecord
  #include AASM
  belongs_to :user
  #Pasamos la clase la cual va a mapiar para hacer referencia con el mismo usuario
  #ya que el friend es un usuario
  belongs_to :friend, class_name: "User"
  #Validamos que solo una vez que puede tener amistad con algun usuario
  #Pasamos un rol al id de la tabla friend
  validates :user_id, uniqueness:{ scope: :friend_id,message: "Amistad duplicada"}
  
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
