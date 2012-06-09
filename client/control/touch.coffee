domready ->
  hammer = new Hammer (document.getElementById "touch-control-overlay")

  hammer.ondragend = (ev) ->
    client.publish '/global', text: "#{ev.direction}: #{Math.floor ev.distance}"