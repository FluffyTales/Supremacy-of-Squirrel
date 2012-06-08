faye         = require "faye"
express      = require "express"
coffee       = require "coffee-script"
sass         = require "sass"
assetManager = require "connect-assetmanager"

# Starting the Webserver:

publicDir = __dirname + '/../public/'
coffeeDir = __dirname + '/../client/'
vendorDir = __dirname + '/../vendor/'
styleDir  = __dirname + '/../style/'

server = express.createServer()

coffeeRenderer = (file, path, index, isLast, callback) ->
  console.log "Compiling CoffeeScript: #{path}"
  callback coffee.compile(file)

sassRenderer = (file, path, index, isLast, callback) ->
  console.log "Compiling SASS: #{path}"
  sass.compile path, (err, css) ->
    throw err if err
    callback css

server.use assetManager
  custom_js:
    route: /\/app\.js/
    path: coffeeDir
    dataType: 'javascript'
    files: ['*']
    preManipulate:
      '^': [coffeeRenderer]

  vendor_js:
    route: /\/vendor\.js/
    path: "#{vendorDir}js/"
    dataType: 'javascript'
    files: ['*']

  custom_css:
    route: /\/app\.css/
    path: styleDir
    dataType: 'css'
    files: ['*']
    preManipulate:
      '^': [sassRenderer]

  vendor_css:
    route: /\/vendor\.css/
    path: "#{vendorDir}css/"
    dataType: 'css'
    files: ['*']

server.use (express.static publicDir)

server.listen 8080

# Starting the Bayeux Server:

bayeux = new faye.NodeAdapter
  mount: "/faye"
  timeout: 45

bayeux.attach(server)
bayeux.listen 8000

# Only for Logging:

bayeux.bind "handshake", (clientId) ->
  console.log "Handshake: #{clientId}"

bayeux.bind "subscribe", (clientId, channel) ->
  console.log "Subscribed: #{clientId} to #{channel}"

bayeux.bind "unsubscribe", (clientId, channel) ->
  console.log "Unsubscribed: #{clientId} from #{channel}"

bayeux.bind "publish", (clientId, channel, data) ->
  console.log "Published by #{clientId} to #{channel}:"
  console.log data

bayeux.bind "disconnect", (clientId) ->
  console.log "Disconnect: #{clientId}"