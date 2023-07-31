extends Area2D

signal hit_shot(body: Node2D)

var speed = 750

var animationExploit = false

func _ready():
	$AnimatedSprite2D.animation =  "shot"
	$AnimatedSprite2D.play()

func _process(delta):
	if !animationExploit :
		position -= transform.y * speed * delta

func _on_body_entered(body):
	if body.is_in_group("asteroids") && !animationExploit:
		body.queue_free()
		animationExploit = true
		#$AnimatedSprite2D.animation =  "exploit"
		$BoomMusic.play()
		$AnimatedSprite2D.play("exploit")
		emit_signal("hit_shot", body)



func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "exploit": 
		queue_free()
