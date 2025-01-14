extends CharacterBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var horizontal_direction = Input.get_axis("move_left", "move_right")
