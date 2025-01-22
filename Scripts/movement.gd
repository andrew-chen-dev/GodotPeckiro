extends CharacterBody2D
@onready var animation = $AnimationPlayer

var screen_size
var time : float = 0
signal goodParry

func _ready():
	screen_size = get_viewport_rect().size

@export var speed : float = 150
@export var parrying = false
@export var attacking = false
@export var isFacingRight = true


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
	if Input.is_action_just_pressed("attack"):
		attack()

	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * speed
	move_and_slide()
	if !parrying && !attacking && can_move:
		if velocity.length() > 0:
			animation.play("peck_walk")
		else:
			animation.play("peck_idle")
	if (velocity.x < 0 && isFacingRight) || (!isFacingRight && velocity.x > 0):
		print("condition met")
		isFacingRight = !isFacingRight
		$".".scale.x = -1




func _physics_process(delta):
	if time > 0:
		time -= delta

	position += velocity * delta
	
	#Locks Peck to Screen
	position = position.clamp(Vector2.ZERO, screen_size)


#PECK PARRY
#The parry needs to lock the player in place for the duration. 
#Additionally, there should be a short active invincible parry window and a longer inactive window where you're stuck in animation.
#Missing a parry should be punishable.
	
func parry():
	if can_move:
		parrying = true
		print("parrying")
		animation.play("peck_parry")

func attack():
	if can_move:
		attacking = true
		print("attacking")
		animation.play("peck_attack")



func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_reflecting_parry_success() -> void:
	goodParry.emit()
