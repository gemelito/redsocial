class Notification < ApplicationRecord
	#Decclara la relacion de usuario a los post
	#y la relacion polimorfica de las notificacioes
  belongs_to :user
  belongs_to :item, polymorphic: true
end
