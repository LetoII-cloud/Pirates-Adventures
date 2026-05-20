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
@onready var hurtbox_collisions := {
	"top": $Hurtboxes/HurtboxTop/CollisionShape2D,
	"middle": $Hurtboxes/HurtboxMiddle/CollisionShape2D,
	"down": $Hurtboxes/HurtboxDown/CollisionShape2D,
}
@onready var hurt_sfx = $HurtSFX


var times_attacked := 0
var protected_zone : String = "middle"
var is_blocking : bool = false

### move to some kind of file reading, resource etc.
@onready var audio_sfx := [
	$BlockingClashSFX/AudioStreamPlayer2D,
	$BlockingClashSFX/AudioStreamPlayer2D2,
 	$BlockingClashSFX/AudioStreamPlayer2D3,
 	$BlockingClashSFX/AudioStreamPlayer2D4,
 	$BlockingClashSFX/AudioStreamPlayer2D5, 
	$BlockingClashSFX/AudioStreamPlayer2D6,
 	$BlockingClashSFX/AudioStreamPlayer2D7,
 	$BlockingClashSFX/AudioStreamPlayer2D8
]

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

func _on_hurtbox_damage_info(dmg: int, zone: String = "middle") -> void:
	take_damage (dmg)


func _on_enemy_dying_take_collision_away() -> void:
	print("FREEING")
	get_node("CollisionShape2D").queue_free()


func _on_enemy_blocking_toggle_blocking(block_active: bool, zone: String) -> void:
	protected_zone = zone if block_active else ''
	is_blocking = block_active
	print (protected_zone)
	

func handle_block_hit() -> void:
	animatedSprite.play("middle_block_hit")
	var rng := RandomNumberGenerator.new()
	var sound_number = rng.randf_range(0, audio_sfx.size()-1)
	audio_sfx [sound_number].play()
	return
	

func _on_hurtbox_top_block_hit() -> void:
	handle_block_hit()

func _on_hurtbox_middle_block_hit() -> void:
	handle_block_hit()


func _on_hurtbox_down_block_hit() -> void:
	handle_block_hit()
