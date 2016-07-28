class Notification < ApplicationRecord
	#Decclara la relacion de usuario a los post
	#y la relacion polimorfica de las notificacioes
  belongs_to :user
  belongs_to :item, polymorphic: true
  after_commit { NotificationBroacastJob.perform_later(self) }
  scope :unviewed, ->{ where(viewed:false) }
  
  def self.for_user(user_id)
	#Notification.where(user_id: user_id).where(viewed:false).count
  	Notification.where(user_id: user_id).unviewed.count

  end
end
