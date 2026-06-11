class_name Enemy extends CharacterBody2D

const SPEED = 50
const ATTACK_RECOVERY_TIME := 0.6
const BLOCK_HIT_ATTACK_RECOVERY_TIME := 0.6
const HURT_COUNTER_ATTACK_WINDOW := 2.0
const HURT_COUNTER_ATTACK_HIT_THRESHOLD := 2

@onready var raycastLeft = $RayCastLeft
@onready var raycastRight = $RayCastRight

@onready var raycastTacticsLeft = $RayCastTacticsLeft
@onready var raycastTacticsRight = $RayCastTacticsRight

@onready var rayCastFloorLeft = $RayCastFloorLeft
@onready var rayCastFloorRight = $RayCastFloorRight

@onready var animatedSprite = $AnimatedSprite2D
@onready var animationPlayer = $AnimationPlayer	
@onready var stateMachine = $StateMachine

@onready var enemyStatistics = $EnemyStatistics

@onready var hurt_sfx = $HurtSFX

@export var enemy_name : String

var times_attacked := 0
var times_hurt := 0
var seconds_since_hurt := 0.0
var protected_zone : String = "middle"

var is_blocking : bool = false:
	set (value):
		is_blocking = value
		if is_blocking:
			block_timer.start()
		else:
			block_timer.stop()
		
var is_blocking_hit := false
var attack_recovery_time := 0.0
var attack_checker := false

@onready var block_timer := $BlockTimer


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
	
	if times_hurt > 0:
		seconds_since_hurt += delta
		
	if seconds_since_hurt > HURT_COUNTER_ATTACK_WINDOW:
		reset_recent_hurt_count()
		
	if attack_recovery_time > 0.0:
		attack_recovery_time = maxf(attack_recovery_time - delta, 0.0)
		
	if attack_checker:
		stateMachine.change_state(EnemyState.ATTACKING)
		### TO-DO : naprawic ze mozna go zajsc od tylu jak blokuje
		### TO-DO : tu moze byc grubo, bo zapomnialem o tym, ze to kontroluje ataki. Ale jak bardzo?
	return


func can_attack() -> bool:
	return attack_recovery_time <= 0.0


func start_attack_recovery(duration: float) -> void:
	attack_recovery_time = maxf(attack_recovery_time, duration)

func should_counter_attack_after_hurt() -> bool:
	return seconds_since_hurt < HURT_COUNTER_ATTACK_WINDOW and times_hurt >= HURT_COUNTER_ATTACK_HIT_THRESHOLD and can_attack()


func reset_recent_hurt_count() -> void:
	seconds_since_hurt = 0.0
	times_hurt = 0


func disable_attack_collision() -> void:
	$AnimatedSprite2D/AttackArea/AttackCollision.set_deferred("disabled", true)
	

func check_can_attack_in_next_frame ():
	attack_checker = true

func set_facing (direction: int) -> void:
	if direction < 0:
		animatedSprite.scale.x = -1
	elif direction > 0:
		animatedSprite.scale.x = 1


func take_damage (dmg: float) -> void:
	if enemyStatistics.health <= 0:
		return

	var was_hurt_state: bool = stateMachine.currentState.name == EnemyState.ENEMYHURT
	var enemyHealth = enemyStatistics.take_damage(dmg)
	times_hurt += 1

	var should_lock_transitions = false
	if enemyHealth <= 0:
		stateMachine.lock_transitions = false
		stateMachine.change_state(EnemyState.ENEMYDYING)
		should_lock_transitions = true
	elif !was_hurt_state:
		stateMachine.change_state(EnemyState.ENEMYHURT)
		should_lock_transitions = true

	if should_lock_transitions:
		stateMachine.lock_transitions = true
		
	hurt_sfx.play()
	return

func _on_hurtbox_damage_info(dmg: int, zone: String = "middle") -> void:
	take_damage (dmg)


func _on_enemy_dying_take_collision_away() -> void:
	get_node("CollisionShape2D").queue_free()


func _on_enemy_attacking_toggle_blocking(block_active: bool, zone: String) -> void:
	handle_blocking(block_active, zone)
	
func handle_blocking(block_active: bool, zone: String):
	protected_zone = zone if block_active else ''
	is_blocking = block_active
	
func handle_block_hit() -> void:

	is_blocking_hit = true
	start_attack_recovery(BLOCK_HIT_ATTACK_RECOVERY_TIME)
	#animationPlayer.set_deferred("stop", null)
	animatedSprite.play("middle_block_hit")
	disable_attack_collision()
	
	var rng := RandomNumberGenerator.new()
	var sound_number = rng.randi_range(0, audio_sfx.size() - 1)
	audio_sfx [sound_number].play()
	
	var broken_block = rng.randf_range(0.0, 1.0)
	if broken_block <= 0.5: # this could be parametrized by enemyStatistics or smth
		handle_blocking(false, '')
		
	handle_risk()


	
	return
	
func handle_risk():
	if enemyStatistics.health > 50 and is_blocking:
		stateMachine.call_deferred('change_state', (EnemyState.CHASING))
		print("chasing!")
	elif enemyStatistics.health > 50 and !is_blocking:
		if can_attack():
			stateMachine.call_deferred('change_state', (EnemyState.ATTACKING))
			print('attacking!')
			check_can_attack_in_next_frame()
	elif enemyStatistics.health <= 50 and !is_blocking:
		stateMachine.call_deferred('change_state',  (EnemyState.GOAWAY))
		print('goaway!')
		

func _on_hurtbox_top_block_hit() -> void:
	handle_block_hit()

func _on_hurtbox_middle_block_hit() -> void:
	handle_block_hit()


func _on_hurtbox_down_block_hit() -> void:
	handle_block_hit()


func _on_block_timer_timeout() -> void:
	handle_blocking(false, '')
	print ('block timer sss')
	#stateMachine.change_state(EnemyState.GOAWAY)
	#naprawic niewidzialne ataki po bloku


func _on_enemy_go_away_toggle_blocking(block_active: bool, zone: String) -> void:
	handle_blocking(block_active, zone)


func _on_enemy_hurt_toggle_blocking(block_active: bool, zone: String) -> void:
	handle_blocking(block_active, zone)
	
#func toggle_hurt_cooldown (hurt_cooldown_on : bool):
	
func is_on_edge ():
	return !rayCastFloorLeft.is_colliding() || !rayCastFloorRight.is_colliding()
