extends RigidBody2D

var speed = 350

#func _process(delta):
	#position += transform.y * speed * delta
	
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_to_group("asteroids")
	$AnimatedSprite2D.play()
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


