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

var direction : int


var sword

var is_attacking := false

func _ready() -> void:
	sword = Equipment.StandardSword.new()


func _unhandled_input(event: InputEvent) -> void:
	print (aiming.is_aiming)
	if playerStatistics.health > 0 and event.is_action_pressed("attack_left") and aiming.is_aiming:
		shoot(aiming.direction)
		get_viewport().set_input_as_handled()
	
func _physics_process(delta: float) -> void:
	# move_and_slide()		
#	if Input.is_action_just_pressed("attack_left") and not is_attacking:
#		is_attacking = true
#		#animatedSprite.play("attack_new")
#		animationPlayer.play("attacktest")
#
#	if Input.is_action_just_pressed("use_rum"):
#		get_node("Equipment").useRum()
#
#	if not is_attacking:
#		update_animation(direction)
#
#	move_and_slide()

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
	stateMachine.change_state(PlayerState.DYING)
	stateMachine.lock_transistions = true
	equipment.queue_free()
		


func _on_equipment_ammo_amount_change(new_amount: int) -> void:
	notify_ui.emit("ammo", new_amount)
	
func shoot (target_position: Vector2) -> void:
	if equipment.ammo > 0:
		equipment.ammo = equipment.ammo-1
		equipment.standard_gun.shoot (global_position, target_position)
	else:
		print("No ammo.")
		
