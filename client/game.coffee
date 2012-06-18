
window.tick = (timeElapsed) ->
   # do nothing for now
   #console.log "HALLO #{timeElapsed}"
   stage.clear()

   if animation.direction == 90
     animation.x += animation.vX
   else
     animation.x -= animation.vX

   if animation.x + 16 > canvas.width
     animation.direction *= -1
     animation.gotoAndPlay 'walk'
   if animation.x - 16 < 0
     animation.direction *= -1
     animation.gotoAndPlay 'walk_h'

   stage.update()

canvas = ->
  document.getElementById "gameCanvas"

context = (canvas) ->
  canvas.getContext '2d'

stage = null
player_image = new Image()
image_loaded = false
spritesheet = null
animation = null

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

  player_image.onload = ->
    spritesheet = new SpriteSheet
      images: [player_image]
      frames:
        width: 64
        height: 64
        regX: 32
        regY: 32
      animations:
        walk: [0, 9, 'walk']

    SpriteSheetUtils.addFlippedFrames spritesheet, true, false, false

    image_loaded = true
    animation = new BitmapAnimation spritesheet
    animation.gotoAndPlay 'walk_h'
    animation.name = 'Player'
    animation.direction = 90
    animation.vX = 4
    animation.x = 16
    animation.y = 32
    animation.currentFrame = 0
    stage.addChild animation

  player_image.src = '/images/player.png'

  Ticker.setFPS 60
  Ticker.addListener(window)


domready ->
  init()


