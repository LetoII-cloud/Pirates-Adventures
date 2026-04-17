extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var animatedSprite = $AnimatedSprite2D

func _ready() -> void:
	print("PLAYER READY")

# var rumBottles = 0;

func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("attack_left"):
		animatedSprite.play("attack_new")
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animatedSprite.play("jumping") # immediate feedback
		
	if Input.is_action_just_pressed("use_rum"):
		get_node("Equipment").useRum()
		
	if Input.is_action_just_pressed("attack_left"):
		animatedSprite.play("attack_new")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animatedSprite.flip_h = false
	elif direction < 0:
		animatedSprite.flip_h = true
		
		
	# Play jump animation
	if not is_on_floor():
		if velocity.y < 0:
			animatedSprite.play("jumping")
		else:
			animatedSprite.play("falling")
	elif direction == 0:
		animatedSprite.play("idle")
	else:
		animatedSprite.play("running")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


#func _on_rum_body_entered(body: Node2D) -> void:
#	rumBottles += 1
#	print("rum bottles : ", rumBottles)


#func _on_area_2d_body_entered(body: Node2D) -> void:
#	if !body.is_in_group("rum"):
#		return
#	rumBottles += 1
#	print("second approach - rum bottles : ", rumBottles)
