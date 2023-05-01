extends Node2D
@export var distance = 500
@export var player: CharacterBody2D
@onready var enemy_scene = load("res://enemy.tscn")
var spawnCount = 3
var loaded = false
var spawnPoint: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPoint = Vector2(get_position().x + 500, y_spawn_value())
#	var player_loc = player.get_position()
#	if player_loc.distance_to(Vector2(spawnPoint.x - distance, spawnPoint.y)) > 100:
#		print("spawn")
#		spawnPoint = Vector2(player_loc.x + distance, player_loc.y)
#		var enemy = enemy_scene.instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
#		add_child(enemy)
#		enemy.set_position(spawnPoint)
	
func y_spawn_value() -> float:
	var bottom = get_viewport_rect().size.y - 250
	var top = 0
	return randf() * (bottom - top)
	
func _physics_process(delta):
	if spawnCount != 0:
		spawnPoint = Vector2(spawnPoint.x + distance, y_spawn_value())
		print("spawn\nEnemy:" + str(spawnPoint.x) + ", " + str(spawnPoint.y))
		var enemy = enemy_scene.instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
		add_child(enemy)
		enemy.set_position(spawnPoint)
#		enemy.set_script(scp)
		spawnCount -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
		
#	var player_loc = player.get_location()
#	spawnPoint = Vector2(player_loc.y, player_loc.x + distance)
#	var enemy = enemy_scene.instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
#	enemy.set_position(spawnPoint)
	pass
