extends Area2D

func _ready() -> void:
	pass
	
func _on_body_entered(body: Node2D) -> void:
	if body is not CharacterBody2D:
		return
	
	if not body.has_node("Equipment"):
		return
		
	var equipment = body.get_node("Equipment")
	equipment.addRum()
	queue_free()
