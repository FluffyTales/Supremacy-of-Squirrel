window.client = new Faye.Client '/faye'
		  
client.subscribe '/global', (message) ->
  output = document.getElementById "output"
  output.innerHTML += "\<p>" + message.text + "\</p>"

# by default, keymaster filters `enter` in textfields.
# We change that here:
key.filter = (event) -> true

key 'enter', ->
  chat_message_box = document.getElementById("chat_message")
  client.publish '/global', text: chat_message_box.value
  chat_message_box.value = ""
  chat_message_box.focus()

domready ->
  (document.getElementById "chat_message").focus()