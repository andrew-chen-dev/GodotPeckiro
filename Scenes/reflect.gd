extends Area2D
#

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("stagger"):
		area.stagger()
		print("PARRIED!!!!!!!!!!!!!!!!!!!!!!!!")
		TestingGround.score += 1
