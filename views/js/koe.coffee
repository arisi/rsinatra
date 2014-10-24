
task = () ->
  $.ajax
    url: "/ajax" 
    type: "POST"
    success: (data) ->
      obj = jQuery.parseJSON(data)
      $("#tick").html(obj.tick)
      $("#stamp").html(obj.stamp)

$(document).ready ->
  timer=setInterval (->
    task()
  ), 500
			  
  
