domready ->
  hammer = new Hammer (document.getElementById "touch-control-overlay")
  console.log("hi")

  hammer.ondrag = (ev) ->
    client.publish '/global', text: ev.direction