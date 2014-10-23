
task = () ->
  console.log "taski"
  $.ajax
    url: "/ajax" 
    type: "POST"
    data: 123
    success: (data) ->
      obj = jQuery.parseJSON(data)
      $("#tick").html(obj.tick)

$(document).ready ->
  console.log "tadaa"
  timer=setInterval (->
    task()
  ), 500
			  
  
