extends Area2D

signal hit

@export var speed = 80.0
var screen_size 


var moving = false
var targetPosition: Vector2
var widthShip = 0
var heightShip = 0

func start(pos):
	show()
	$CollisionShape2D.disabled = false

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	var capsuleShape = $CollisionShape2D.shape as CapsuleShape2D
	widthShip = capsuleShape.radius * 2.0
	heightShip = capsuleShape.height + capsuleShape.radius * 2.0
	
	

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		var touchPosition = get_viewport().get_mouse_position()
		moving = true

		var on_dimension_in_y = touchPosition.y +  (heightShip / 2)
		var on_dimension_in_x = touchPosition.x + (widthShip / 2)

		if (widthShip / 2) > touchPosition.x:
			touchPosition.x = widthShip
		elif on_dimension_in_x > screen_size.x:
			touchPosition.x = 	screen_size.x - widthShip

		if (heightShip / 2) > touchPosition.y:
			touchPosition.y = heightShip
		elif on_dimension_in_y > screen_size.y:
			touchPosition.y = 	screen_size.y - widthShip

		targetPosition = touchPosition

func _process(delta):
	if moving:
		"""var direction = (targetPosition - global_position).normalized()
		#print("Direccion", direction)
		var distance = (targetPosition - global_position).length()
		#print("distance", distance)
		
		print("process", distance, "targetPosition", targetPosition, "global_position", global_position)
		if distance > 1.0:
			var movement = direction * speed * delta
			position += movement
			
			position.x = clamp(position.x, 0, screen_size.x)
			position.y = clamp(position.y, 0, screen_size.y)
		else:
			moving = false"""
		var direction = (targetPosition - global_position).normalized()
		position = position.lerp(targetPosition, speed / 1000)



func _on_body_entered(body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	$GameOver.play()
	$CollisionShape2D.set_deferred("disabled", true)
