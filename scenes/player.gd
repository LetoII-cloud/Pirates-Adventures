extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var animatedSprite = $AnimatedSprite2D

var is_attacking := false

func _ready() -> void:
	print("PLAYER READY")
	animatedSprite.animation_finished.connect(_on_animated_sprite_2d_animation_finished)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("move_left", "move_right")

	if direction > 0:
		animatedSprite.flip_h = false
	elif direction < 0:
		animatedSprite.flip_h = true

	if Input.is_action_just_pressed("attack_left") and not is_attacking:
		is_attacking = true
		animatedSprite.play("attack_new")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("use_rum"):
		get_node("Equipment").useRum()

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_attacking:
		update_animation(direction)

	move_and_slide()

func update_animation(direction: float) -> void:
	if not is_on_floor():
		if velocity.y < 0:
			animatedSprite.play("jumping")
		else:
			animatedSprite.play("falling")
	elif direction == 0:
		animatedSprite.play("idle")
	else:
		animatedSprite.play("running")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animatedSprite.animation == "attack_new":
		is_attacking = false
