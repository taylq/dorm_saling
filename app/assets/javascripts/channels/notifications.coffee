App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    $('.notificationlist').prepend "#{data.notification}"
    $('.open_notification').html data.counter
