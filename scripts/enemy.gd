class_name Enemy extends CharacterBody2D

const SPEED = 50

@onready var raycastLeft = $RayCastLeft
@onready var raycastRight = $RayCastRight

@onready var raycastTacticsLeft = $RayCastTacticsLeft
@onready var raycastTacticsRight = $RayCastTacticsRight

@onready var animatedSprite = $AnimatedSprite2D
@onready var animationPlayer = $AnimationPlayer	
@onready var stateMachine = $StateMachine

@onready var enemyStatistics = $EnemyStatistics

@onready var hurt_sfx = $HurtSFX

func _ready() -> void:
	
	return


func _process(delta: float) -> void:
	
	return
	

func set_facing (direction: int) -> void:
	if direction < 0:
		animatedSprite.scale.x = -1
	elif direction > 0:
		animatedSprite.scale.x = 1


func take_damage (dmg: float) -> void:
	var enemyHealth = enemyStatistics.take_damage(dmg)
	hurt_sfx.play()

	if stateMachine.currentState.name != EnemyState.ENEMYHURT and enemyStatistics.health > 0:
			stateMachine.change_state(EnemyState.ENEMYHURT)
			stateMachine.lock_transistions = true
			
	if enemyStatistics.health <= 0:
		stateMachine.change_state(EnemyState.ENEMYDYING)
		
	return


func _on_hurtbox_damage_info(dmg: int) -> void:
	take_damage (dmg)


func _on_enemy_dying_take_collision_away() -> void:
	print("FREEING")
	get_node("CollisionShape2D").queue_free()
