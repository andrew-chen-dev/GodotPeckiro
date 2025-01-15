extends CharacterBody2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

@export var speed : float = 150
var can_move : bool = true:
	set(value):
		can_move = value
		if value == false:
			speed = 0
		else:
			speed = 150

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * speed
	move_and_slide()
	
	if velocity.length() > 0:
		$Peck.play("walk")
	else:
		$Peck.play("IDLE")
		
	
	position += velocity * delta
	
	#Locks Peck to Screen
	position = position.clamp(Vector2.ZERO, screen_size)
		
	if velocity.x < 0:
		$Peck.flip_h = true
	elif velocity.x > 0:
		$Peck.flip_h = false
		
		
	#PECK PARRY
	#The parry needs to lock the player in place for the duration. 
	#Additionally, there should be a short active invincible parry window and a longer inactive window where you're stuck in animation.
	#Missing a parry should be punishable.
	

	if Input.is_action_pressed("parry"):
			$Peck.play("parryAttempt")

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
