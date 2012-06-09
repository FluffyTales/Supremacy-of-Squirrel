
canvas = ->
  document.getElementById "gameCanvas"

context = (canvas) ->
  canvas.getContext '2d'

init = ->
  canvas = canvas()
  context = context(canvas)
  canvas.width = 1024
  canvas.height = 768
  stage = new Stage(canvas)
  stage.autoClear = true

  stage.addChild(new Text('Hello there! (Canvas)', '36px Arial', '#777777'))

  stage.update()


domready ->
  init()


