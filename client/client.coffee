window.client = new Faye.Client '/faye'
		  
client.subscribe '/global', (message) ->
  output = document.getElementById "output"
  output.innerHTML = "\<p>#{message.text}\</p>"