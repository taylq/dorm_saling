class Notification < ApplicationRecord
  after_create_commit :notification

  private

  def notification
    NotificationBroadcastJob.perform_later Notification.count, self
  end
end
