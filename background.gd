extends ParallaxBackground


var stop = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !stop:
		scroll_offset.y -= 60*delta


func _stop():
	stop = true


func _play():
	stop = false
