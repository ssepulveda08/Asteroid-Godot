extends Node

@export var shot_scene: PackedScene

const asteroid_scene = preload("res://Asteroids/asteroid_1.tscn")
const asteroid_scene_1 = preload("res://Asteroids/asteroid_2.tscn")

var speed_asteroid = 1.0

func _ready():
	randomize()
	$HUD.show()
	$Background._stop()

func _on_start_timer_timeout():
	#print("POTATO")
	$ShotTimer.start()

func _on_shot_timer_timeout():
	var shot = shot_scene.instantiate()
	shot.connect("hit_shot", _on_hit_shot)
	shot.position = $Payer.position
	add_child(shot)
	
func _on_hit_shot(body: Node2D):
	#print("test", body)
	$Score.add_score(10)

func _on_asteroid_timer_timeout():
		
	var module = randi_range(1, 10) % 2
	var asteroid 
	
	if module == 0:
		asteroid = asteroid_scene_1.instantiate()
	else:
		asteroid = asteroid_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node(^"Asteroid2D/PathFollow2D")
	mob_spawn_location.progress = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	asteroid.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	asteroid.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0) * speed_asteroid
	
	asteroid.linear_velocity = velocity.rotated(direction)
	

	# Spawn the mob by adding it to the Main scene.
	add_child(asteroid)


func _on_payer_hit():
	gamer_over()
	
func start_gamer():
	$StartPosition.move_local_x(360)
	$StartPosition.move_local_y(1000)
	$StartTimer.start()
	$AsteroidTimer.start()
	$Payer.start($StartPosition.position)
	$Background._play()
	$Music_bg.play()
	$HUD.hide()
	$Score.resetting_score()
	$Score.show()

func gamer_over():
	$StartTimer.stop()
	$ShotTimer.stop()
	$AsteroidTimer.stop()
	$Background._stop()
	$Music_bg.stop()
	$HUD.show()
	$Score.hide()
	$Score.validate_high_score()
	$HUD._refresh_score()


func _on_hud_on_pressed_start():
	start_gamer()


func _on_score_update_level():
	#print("POTATO UPDATE LEVEL")
	speed_asteroid += 1
	var timeraa = $AsteroidTimer.wait_time 
	print("Timer", timeraa)
	timeraa -= 0.5
	$AsteroidTimer.wait_time = timeraa
