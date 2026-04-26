class_name EnemyState extends State

const IDLE = "EnemyIdle"
const WALKING = "EnemyWalking"
const RUNNING = "EnemyRunning"
const JUMPING = "EnemyJumping"
const FALLING = "EnemyFalling"
const ATTACKING = "EnemyAttacking"
const CHASING = "EnemyChasing"
const GOAWAY = "EnemyGoAway"
const ENEMYHURT = "EnemyHurt"
const ENEMYDYING = "EnemyDying"


var enemy: Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null, "The EnemyState state type must be used only in the enemy scene. It needs the owner to be an Enemy node.")

func is_raycast_colliding_with_player (raycastLeft : RayCast2D, raycastRight : RayCast2D, direction : int) -> bool:
	var collidingRaycast = null
	if raycastLeft.is_colliding() and direction < 0:
		collidingRaycast = raycastLeft
	elif raycastRight.is_colliding() and direction > 0:
		collidingRaycast = raycastRight
		
	var collidingObjIsPlayer = collidingRaycast and collidingRaycast.get_collider() is Player

	return collidingObjIsPlayer

func handle_movement (direction: int, currentSpeed: float) -> void:
	handle_movement_with_direction_flag(direction, currentSpeed, true)
	
func handle_movement_with_direction_flag (direction: int, currentSpeed: float, turnAroundFlag: bool) -> void:
	enemy.velocity.x = direction * currentSpeed
	if turnAroundFlag:
		if direction > 0:
			enemy.animatedSprite.flip_h = false
		elif direction < 0:
			enemy.animatedSprite.flip_h = true
		
	enemy.move_and_slide()
