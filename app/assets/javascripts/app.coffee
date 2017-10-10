(($) ->

  user_trigger = $('.user_trigger')
  user_trigger_menu = $('body')

  user_trigger.click (e) ->
    e.preventDefault()
    user_trigger_menu.toggleClass('open_user_trigger')

  $('body .site-container').click ->
    user_trigger_menu.removeClass('open_user_trigger')

  $('a[data-method=delete]').click ->
    confirms = $(this).data('confirm')
    return confirm(confirms)
) jQuery
