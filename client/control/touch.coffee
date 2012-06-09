domready ->
  overlay = document.getElementById "touch-control-overlay"
  hammer = new Hammer overlay

  hammer.ondragend = (ev) ->
    direction_info = switch ev.direction
      when "left", "right" then "#{ev.direction}: #{Math.floor ((ev.distance / overlay.clientWidth) * 100)}%"
      when "up", "down" then "#{ev.direction}: #{Math.floor ((ev.distance / overlay.clientHeight) * 100)}%"

    client.publish '/global', text: direction_info