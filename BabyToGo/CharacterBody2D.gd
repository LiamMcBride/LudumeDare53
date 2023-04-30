extends CharacterBody2D

@export var rot_amount = 1
@export var rot_limit = 60
@export var max_y_speed = 1
@export var upper_y_limit = -70
@export var lower_y_limit = 300
@export var stamina = 6000
@export var progress: TextureProgressBar
const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	progress.max_value = stamina
	progress.value = stamina

func get_y_velocity():
	return 10

func _process(delta):
	progress.value -= 1
	if Input.is_action_pressed("LEFT"):
		var cur_rot = get_rotation()
		set_rotation(clamp(cur_rot + deg_to_rad(-rot_amount), deg_to_rad(-rot_limit), deg_to_rad(rot_limit)))
	if Input.is_action_pressed("RIGHT"):
		var cur_rot = get_rotation()
		set_rotation(clamp(cur_rot + deg_to_rad(rot_amount), deg_to_rad(-rot_limit), deg_to_rad(rot_limit)))

func _physics_process(delta):
	var bottom = get_viewport_rect().size.y - 250
	# Add the gravity.
	if progress.value > 0:
		if position.y < -50:
			var neg = clamp(get_rotation(), 0, rot_limit)
			velocity.y = 11 * rad_to_deg(neg)
		elif position.y > bottom:
			var pos = clamp(get_rotation(), -1 * rot_limit, 0)
			velocity.y = 11 * rad_to_deg(pos)
		else:
			velocity.y = 11 * rad_to_deg(get_rotation())
	else:
		if position.y < -100:
			velocity.y = 5
		else:
			velocity.y += 5


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	velocity.x = SPEED
	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
