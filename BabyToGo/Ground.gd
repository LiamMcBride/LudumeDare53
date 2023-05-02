extends ParallaxLayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	motion_offset -= Vector2(5, 0)
