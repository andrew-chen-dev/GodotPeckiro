extends Area2D

@onready var animation = owner.find_child("AnimationPlayer")

func stagger():
	animation.play("farmer_stagger")

func _on_animation_finished(anim_name: StringName) -> void:
	animation.play("farmer_stab")
	
