extends CharacterBody2D
@onready var animation = $AnimationPlayer

var screen_size
var time : float = 0
signal goodParry

func _ready():
	screen_size = get_viewport_rect().size
	animation.play("peck_idle")

@export var speed : float = 150
@export var parrying = false
@export var attacking = false
@export var is_facing_right = true

@export var can_move : bool = true:
	set(value):
		can_move = value
		if value == false:
			speed = 0
		else:
			speed = 150

func _process(delta):
	if Input.is_action_just_pressed("parry"):
		parry()

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if time > 0:
		time -= delta
	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * speed
	move_and_slide()
	
	if can_move:
		if velocity.length() > 0:
			animation.play("peck_walk")
			print("walking")
		else:
			animation.play("peck_idle")
			print("idle")
		if velocity.x < 0:
			$Peck.flip_h = true
			
		if velocity.x > 0:
			$Peck.flip_h = false
			

		

		
	position += velocity * delta
	
	#Locks Peck to Screen
	position = position.clamp(Vector2.ZERO, screen_size)
		
		

	
		
	#PECK PARRY
	#The parry needs to lock the player in place for the duration. 
	#Additionally, there should be a short active invincible parry window and a longer inactive window where you're stuck in animation.
	#Missing a parry should be punishable.
	
func parry():
	parrying = true
	print("parrying")
	animation.play("peck_parry")




func update_animation():
	if !parrying:
		if velocity.length() > 0:
			animation.play("peck_walk")
		else:
			animation.play("peck_idle")
		if velocity.x < 0:
			$Peck.flip_h = true

		elif velocity.x > 0:
			$Peck.flip_h = false


		
	
	
#func _input(event):
	#
#
#func _on_animation_finished(anim_name: StringName) -> void:
	#can_move = false


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false




func _on_reflecting_parry_success() -> void:
	goodParry.emit()
