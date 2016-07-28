class NotificationBroacastJob < ApplicationJob
  queue_as :default

  def perform(notification)
  	notification_count = Notification.for_user(notification.user_id)
    # Do something later
    ActionCable.server.broadcast "notifications.#{notification.user_id}",
    	{action: "new_notification", message:notification_count }
  end
end  