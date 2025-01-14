extends CharacterBody2D

@export var speed = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	var vertical_direction = Input.get_axis("move_up", "move_down")
	
	velocity.y = speed * vertical_direction
	velocity.x = speed * horizontal_direction

	move_and_slide()
	
	if velocity.x == 0 && velocity.y == 0:
		$Peck.play("IDLE")
	if horizontal_direction != 0 || vertical_direction != 0:
		$Peck.play("walk")
