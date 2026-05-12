class_name Dying extends PlayerState

@onready var timer = $Timer

func enter () -> void:
	player.animatedSprite.play("dying")
	print("You died!")
	player.get_node("CollisionShape2D").queue_free()
	
	# the line below causes error later when the character is still technically 
	# falling to the abyss and the "play animation falling" is called
	# body.get_node("AnimatedSprite2D").queue_free()
	Engine.time_scale = 0.5
	timer.start()
	
	
func _on_timer_timeout():
	Engine.time_scale = 1
	print("reloading")
	get_tree().reload_current_scene()

func handle_physics (delta: float) -> void:
	
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	
	return
