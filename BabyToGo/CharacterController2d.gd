extends Node2D
@export var rot_amount = 10
@export var rot_limit = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("UP"):
		var cur_rot = get_rotation()
		set_rotation(clamp(cur_rot + deg_to_rad(-rot_amount), deg_to_rad(-rot_limit), deg_to_rad(rot_limit)))
	if Input.is_action_pressed("DOWN"):
		var cur_rot = get_rotation()
		set_rotation(clamp(cur_rot + deg_to_rad(rot_amount), deg_to_rad(-rot_limit), deg_to_rad(rot_limit)))
#	if Input.is_action_pressed("DOWN"):
#		var cur_rot = get_rotation()
#		set_rotation(clamp(cur_rot + deg_to_rad(rot_amount), deg_to_rad(-rot_limit), deg_to_rad(rot_limit)))
