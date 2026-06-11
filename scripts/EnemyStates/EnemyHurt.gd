extends EnemyState

@export var hurt_cooldown : float
@export var blocking_hurt_cooldown : float = 1.7
var time_since_hurt : float
var current_hurt_cooldown : float
var should_block_during_hurt := false

signal hurt_finished ()

func enter () -> void:
	super()
	time_since_hurt = 0
	current_hurt_cooldown = hurt_cooldown
	should_block_during_hurt = false
	enemy.animationPlayer.pause()
	enemy.get_node("AnimatedSprite2D/AttackArea/AttackCollision").set_deferred("disabled", true)
	enemy.animatedSprite.play("hit")
	
	var rng := RandomNumberGenerator.new()
	var chance_for_block := rng.randf_range(0, 1)
	if chance_for_block < 0.33:
		current_hurt_cooldown = blocking_hurt_cooldown
		should_block_during_hurt = true

func handle_physics (delta: float) -> void:
		
	return
	
func handle_input () -> void:
	
	return
	
func handle_update () -> void:
	time_since_hurt += get_process_delta_time()
	if time_since_hurt >= current_hurt_cooldown:
		handle_hurt_cooldown()
	if should_block_during_hurt and !enemy.is_blocking:
		enemy.animatedSprite.stop()
		enemy.animatedSprite.play("blocking while hit")
		toggle_blocking.emit(true, "middle")
	if enemy.should_counter_attack_after_hurt():
		enemy.stateMachine.lock_transitions = false
		enemy.reset_recent_hurt_count()
		print('emituje attacking!!!!!!!')
		finished.emit(ATTACKING)
	return
	
func handle_hurt_cooldown () -> void:
		hurt_finished.emit()
		finished.emit(CHASING)

signal toggle_blocking (block_active : bool, zone: String)
