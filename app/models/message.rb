class Message < ApplicationRecord
  after_create_commit :notify

  private

  def notify
    Notification.create event: I18n.t("became", body: body)
  end
end
