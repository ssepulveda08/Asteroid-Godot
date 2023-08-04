extends Node

@export var shot_scene: PackedScene

@export var speed_asteroid = 2

const asteroid_scene = preload("res://Asteroids/asteroid_1.tscn")
const asteroid_scene_1 = preload("res://Asteroids/asteroid_2.tscn")


@onready var location_bottom = $BaseBottom/PathFollow2D 
@onready var top_spawn_location = $Asteroid2D/PathFollow2D

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
	shot.position = $Player.position
	add_child(shot)
	
func _on_hit_shot(body: Node2D):
	$Score.add_score(10)

func _on_asteroid_timer_timeout():
	var asteroid = _get_asteroid()

	top_spawn_location.progress = randi()
	asteroid.position = top_spawn_location.position

	asteroid.rotation = _get_rotation_asteroid()

	# Choose the velocity for the mob.
	
	
	var a =  _get_location_where_asteroire_go().x
	var velocity = Vector2(randf_range(100, 150), 0.0) * speed_asteroid
	
	asteroid.linear_velocity = velocity.rotated(asteroid.rotation)
	
	#asteroid.linear_velocity = _get_location_where_asteroire_go() * speed_asteroid
	

	# Spawn the mob by adding it to the Main scene.
	add_child(asteroid)
	
func _get_rotation_asteroid():
	var direction = top_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	return direction
	
	
func _get_location_where_asteroire_go():
	location_bottom.progress = randi()
	return location_bottom.position
	
func _get_asteroid():
	var module = randi_range(1, 10) % 2
	var asteroid 
	
	if module == 0:
		asteroid = asteroid_scene_1.instantiate()
	else:
		asteroid = asteroid_scene.instantiate()
		
	return asteroid


func _on_player_hit():
	gamer_over()
	
func start_gamer():
	$StartPosition.move_local_x(360)
	$StartPosition.move_local_y(1000)
	$StartTimer.start()
	$AsteroidTimer.start()
	$Player.start($StartPosition.position)
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
	speed_asteroid += 1
	var timeraa = $AsteroidTimer.wait_time 
	print("Timer", timeraa)
	timeraa -= 0.5
	$AsteroidTimer.wait_time = timeraa
