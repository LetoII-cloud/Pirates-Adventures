extends Area2D

@onready var timer = $Timer

# TO-DO : update some status on Player to later block moving when he's dead
func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	body.get_node("CollisionShape2D").queue_free()
	
	# the line below causes error later when the character is still technically 
	# falling to the abyss and the "play animation falling" is called
	# body.get_node("AnimatedSprite2D").queue_free()
	Engine.time_scale = 0.5
	timer.start()
	
	
func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
