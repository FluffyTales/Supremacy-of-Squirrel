
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

  stage.onMouseMove = ->
    console.log "mouse moved"
  stage.onMouseDown = ->
    console.log "mouse down"

  txt = new Text('Hello there from Canvas', "bold 14px Arial", '#FFF')
  txt.x = 200
  txt.y = 100
  stage.addChild(txt)

  stage.update()


domready ->
  init()


