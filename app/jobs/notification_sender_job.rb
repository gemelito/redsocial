class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform(item)
  	#Para dormir de trabajo en segundos
  	#sleep(100)
    # Do something later
    #obtenmos el item con el usuario y los envia
    item.user_ids.each do |user_id|
    	Notification.create(item: item, user_id: user_id)
    end
  end
end
