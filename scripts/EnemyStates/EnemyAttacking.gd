extends EnemyState

@export var delayed_chase_seconds : int

const ATTACK_TOP := "top"
const ATTACK_MIDDLE := "middle"
const ATTACK_BOTTOM := "bottom"

var ATTACK_BOTTOM_ANIMATION : String
var ATTACK_MIDDLE_ANIMATION : String
var ATTACK_TOP_ANIMATION : String 

### ATTACKING
var attack_areas := [
	{ "name": ATTACK_BOTTOM, "chance": 0.33, "animation": ATTACK_BOTTOM_ANIMATION },
	{ "name": ATTACK_MIDDLE, "chance": 0.66, "animation": ATTACK_MIDDLE_ANIMATION },
	{ "name": ATTACK_TOP, "chance": 1.0, "animation": ATTACK_TOP_ANIMATION }
]

var attacked_area : String

var direction := -1
var delayed_chase_time_left := 0.0


func enter() -> void:
	super()
	delayed_chase_time_left = 0.0

	if enemy.is_blocking:
		toggle_blocking.emit(false, '')
	
	enemy.start_attack_recovery(enemy.ATTACK_RECOVERY_TIME)
	attack()
		
	enemy.animationPlayer.seek(0.0, true)
	enemy.times_attacked += 1
	return

func handle_input () -> void:
	
	return
	
func handle_physics (delta : float) -> void:
	
	return

func handle_update () -> void:
	if delayed_chase_time_left > 0.0:
		delayed_chase_time_left -= get_process_delta_time()
		if enemy.is_blocking_hit:
			enemy.is_blocking_hit = false
			enemy.animatedSprite.play("middle_block_hit")

		if delayed_chase_time_left <= 0.0:
			finished.emit(CHASING)

	return

func attack() -> void:
	var rng := RandomNumberGenerator.new()
	var roll := rng.randf()

	attacked_area = ""

	for area in attack_areas:
		if roll <= area["chance"]:
			attacked_area = area["name"]
			break

	if attacked_area == "top":
		enemy.animationPlayer.play("attack_toptest")
	elif attacked_area == "middle":
		enemy.animationPlayer.play("attack_newtest")
	else:
		enemy.animationPlayer.play("attack_newtest")
	print("Attacked area: ", attacked_area)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "attack_newtest" and anim_name != "attack_toptest":
		return
	
	var rng := RandomNumberGenerator.new()
	var chance_for_chasing := rng.randf_range(0, 1)
	if chance_for_chasing < 0.3:
		attack()
	elif chance_for_chasing >= 0.3 and chance_for_chasing < 0.6:
		print('delayed chase!')
		
		enemy.disable_attack_collision()
		enemy.velocity.x = 0.0
		toggle_blocking.emit(true, "middle")
		enemy.animatedSprite.play("blocking")
		delayed_chase_time_left = delayed_chase_seconds
	else:
		toggle_blocking.emit(true, "middle")
		finished.emit(GOAWAY)
		

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtboxes"):
		area.take_damage(enemy.enemyStatistics.attack_strength, attacked_area)
		
signal toggle_blocking (block_active : bool, zone: String)
