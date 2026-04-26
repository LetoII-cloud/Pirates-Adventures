class_name Player extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var animationPlayer := $AnimationPlayer
@onready var animatedSprite = $PlayerSprite

@onready var eq = $Equipment

@onready var stateMachine = $StateMachine

var sword

var is_attacking := false

func _ready() -> void:
		
	sword = Equipment.StandardSword.new()
	
	
	

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
	if direction < 0:
		animatedSprite.scale.x = -1
	elif direction > 0:
		animatedSprite.scale.x = 1

		
# If you do not create a RESET track in your AnimationPlayer, you will get errors, including your Player sprite not starting in the correct position when you load the scene. 

#To avoid problems, create another animation in AnimatedSprite2D called RESET (all caps) and use the FIRST idle down frame (frame 0) that you used for the idle down animation.

#Then in AnimationPlayer, create a RESET track and key the RESET frame from your AnimatedSprite2D.
