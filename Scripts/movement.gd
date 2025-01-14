extends CharacterBody2D

@export var speed := 10000.0

var parryLock = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	#PECK MOVEMENT
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	var vertical_direction = Input.get_axis("move_up", "move_down")
	
	velocity.y = _delta * speed * vertical_direction
	velocity.x = _delta * speed * horizontal_direction

	move_and_slide()
	
	#PECK IDLE ANIMATION
	if velocity.x == 0 && velocity.y == 0:
		$Peck.play("IDLE")
	
	#PECK MOVE ANIMATION
	if horizontal_direction != 0 || vertical_direction != 0:
		if horizontal_direction <0:
				$Peck.set_scale(Vector2(-1,1))
		if horizontal_direction >0:
				$Peck.set_scale(Vector2(1,1))
				
		$Peck.play("walk")
		
	#PECK ATTACK
	#an animation plays where you wind back slowly, opposite of direction currently faced, and spin attack 
	#literally rotate peck. make him the hitbox
	###TBD###########################
	#if Input.is_action_pressed("attack"):
		#$AnimationPlayer.play("peckAttack")

		
	
		
	#PECK PARRY
	#The parry needs to lock the player in place for the duration. 
	#Additionally, there should be a short active invincible parry window and a longer inactive window where you're stuck in animation.
	#Missing a parry should be punishable.
		

	if Input.is_action_pressed("parry"):
			$Peck.play("parryAttempt")
