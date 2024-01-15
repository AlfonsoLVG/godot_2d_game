extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout():
	# Create a new instance of the mob scene
	var mob = mob_scene.instantiate()
	
	# Choose a random location on Path2D
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Set the enemy direction perpendicular to the path direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Set the enemy position in a random location
	mob.position = mob_spawn_location.position
	
	# Add randomness to the direction
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Choose the velocity of the enemy
	var velocity = Vector2(randf_range(150.0, 200.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the enemy by adding it to the main scene
	add_child(mob)


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
