#Player controller via Godot template
#Modified by Luke, Tad, Liam

extends CharacterBody2D

var health = 100


@export var rot_amount = 1
@export var rot_limit = 60
@export var max_y_speed = 1
@export var upper_y_limit = -70
@export var lower_y_limit = 300
@export var stamina = 300
@export var progress: TextureProgressBar
@export var health_bar: TextureProgressBar
@export var cam: Camera2D

#sound
@export var gameMusic: AudioStreamPlayer2D
@export var gameOverMusic: AudioStreamPlayer2D
@export var menuMusic: AudioStreamPlayer2D

const SPEED = 50.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	gameMusic.play()
	progress.max_value = stamina
	progress.value = stamina
	health_bar.max_value = health
	health_bar.value = health

func get_y_velocity():
	return 10

#player dies
func death():
	gameMusic.playing = false
	if gameOverMusic.playing == false:
		gameOverMusic.play()
	

#Player hits object	
func hit():
	pass

func _process(delta):
	#death
	if health <= 0:
		death()
	
	
	if Input.is_action_pressed("LEFT"):
		var cur_rot = get_rotation()
		set_rotation(clamp(cur_rot + deg_to_rad(-rot_amount), deg_to_rad(-rot_limit), deg_to_rad(rot_limit)))
	if Input.is_action_pressed("RIGHT"):
		var cur_rot = get_rotation()
		set_rotation(clamp(cur_rot + deg_to_rad(rot_amount), deg_to_rad(-rot_limit), deg_to_rad(rot_limit)))

func going_up() -> bool :
	return get_rotation() <= 0
	
func at_top_of_screen() -> bool:
	return position.y < -50

func at_bottom_of_screen() -> bool:
	var bottom = get_viewport_rect().size.y - 250
	return position.y > bottom

func _physics_process(delta):
	# Add the gravity.
#	print("Playr:" + str(get_position().x) + " " + str(get_position().y))
	if progress.value > 0:
		if at_top_of_screen(): #player is stuck at top of screen
			var neg_pos = clamp(get_rotation(), 0, rot_limit) #only allow downward vel
			velocity.y = 11 * rad_to_deg(neg_pos)
		elif at_bottom_of_screen(): #Stuck on botom
			var pos = clamp(get_rotation(), -1 * rot_limit, 0)
			velocity.y = 11 * rad_to_deg(pos)
		else: #normal
			velocity.y = 11 * rad_to_deg(get_rotation())
	else:
		death()
		if position.y < -100:
			velocity.y = 5
		else:
			velocity.y += 5
			
	if going_up():
		progress.value -= 1


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

#	velocity.x = SPEED
#	velocity.x = move_toward(velocity.x, 10, SPEED)
#	velocity.x = SPEED
#	cam.set_position(Vector2(get_position().x, get_position().y))

	move_and_slide()


func _on_player_enter_area(body_rid, body, body_shape_index, local_shape_index):
	health_bar.value -= 10
