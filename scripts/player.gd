class_name Player extends CharacterBody2D

@export var SPEED : float # originally 200
@export var JUMP_VELOCITY : float # originally -300

@onready var animationPlayer := $AnimationPlayer
@onready var animatedSprite = $PlayerSprite
@onready var playerStatistics = $PlayerStatistics
@onready var equipment = $Equipment

@onready var stateMachine = $StateMachine
@onready var hurt_sfx = $HurtSFX
@onready var aiming = $Aiming

var is_alive : bool = true
var current_rope: Rope
var nearby_rope: Rope
var keep_velocity_on_next_jump := false

var direction : int
var sword

func _ready() -> void:
	sword = Equipment.StandardSword.new()
	


func _unhandled_input(event: InputEvent) -> void:
	if playerStatistics.health > 0 and event.is_action_pressed("attack_left") and aiming.is_aiming:
		shoot(aiming.direction)
		get_viewport().set_input_as_handled()
	
func _physics_process(delta: float) -> void:
	
	return

func set_facing (direction: int) -> void:
	self.direction = self.direction if direction == 0 else direction # don't change if param=0
	if direction < 0:
		animatedSprite.scale.x = -1
	elif direction > 0:
		animatedSprite.scale.x = 1

		
# If you do not create a RESET track in your AnimationPlayer, you will get errors, including your Player sprite not starting in the correct position when you load the scene. 

#To avoid problems, create another animation in AnimatedSprite2D called RESET (all caps) and use the FIRST idle down frame (frame 0) that you used for the idle down animation.

#Then in AnimationPlayer, create a RESET track and key the RESET frame from your AnimatedSprite2D.

func _on_hurtbox_damage_info(dmg: int) -> void:
	take_damage (dmg)

func take_damage (dmg: float) -> void:
	print('taking dmg')
	var health = playerStatistics.take_damage(dmg)
	hurt_sfx.play()
	
	if stateMachine.currentState.name != PlayerState.HURT and playerStatistics.health > 0:
			stateMachine.change_state(PlayerState.HURT)
			#stateMachine.lock_transistions = true
			
	if playerStatistics.health <= 0:
		die()

signal notify_ui (new_health : int)

func _on_player_statistics_health_changed(new_health: int) -> void:
	notify_ui.emit("health", new_health)

func die () -> void:
	if !is_alive:
		return
	is_alive = false
	if current_rope:
		current_rope.release_player()
	stateMachine.change_state(PlayerState.DYING)
	stateMachine.lock_transistions = true
	equipment.queue_free()
		


func _on_equipment_ammo_amount_change(new_amount: int) -> void:
	notify_ui.emit("ammo", new_amount)
	
func _on_equipment_rum_amount_change(new_amount: int) -> void:
	notify_ui.emit("rum", new_amount)
	
func shoot (target_position: Vector2) -> void:
	if equipment.ammo > 0:
		equipment.ammo = equipment.ammo-1
		equipment.standard_gun.shoot (global_position, target_position)
	else:
		print("No ammo.")

func grab_rope(rope: Rope) -> void:
	if not is_alive:
		return

	current_rope = rope
	stateMachine.change_state(PlayerState.SWINGING)

func release_rope(release_velocity: Vector2, apply_jump := false) -> void:
	current_rope = null
	velocity = release_velocity
	if apply_jump:
		velocity.y += JUMP_VELOCITY
		keep_velocity_on_next_jump = true

func enter_rope_area(rope: Rope) -> void:
	nearby_rope = rope

func exit_rope_area(rope: Rope) -> void:
	if nearby_rope == rope:
		nearby_rope = null

func try_grab_nearby_rope() -> bool:
	if is_on_floor() or not nearby_rope:
		return false

	nearby_rope.grab_player(self)
	return current_rope == nearby_rope
		
