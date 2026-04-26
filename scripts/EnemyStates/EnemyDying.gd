extends EnemyState

signal take_collision_away ()

@onready var deadTimer = $Timer

func enter () -> void:
	enemy.animatedSprite.play ("dying")
	deadTimer.start()
	enemy.stateMachine.lock_transistions = true
	take_collision_away.emit()
	return

func handle_physics (delta: float) -> void:
	enemy.velocity += enemy.get_gravity() * delta
	enemy.move_and_slide()
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	
	return

func _on_timer_timeout():
	enemy.queue_free()
