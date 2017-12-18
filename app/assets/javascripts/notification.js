$(document).on('turbolinks:load', function() {
  $('.open_notification').click(function() {
    $('.notificationcontainer').fadeToggle(300);
    $('#notification_count').fadeOut('fast');
    return false;
  });
});

$(document).click(function() {
  $('.notificationcontainer').hide();
});
