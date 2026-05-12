class_name Bullet extends Node2D

@export var velocity : int = 900
@export var air_resistance : float
@export var velocity_damage_multiplier : float = 0.0012
@export var owner_collision_grace_time : float = 0.1

var gravity : int = 0

# TO-DO : zamienic na wektory żeby siła nośna i grawitacja się składały
var gravity_modifier = 50

var direction := Vector2.RIGHT
var damage : int = 95
var time_alive := 0.0

func _ready() -> void:
	
	return

func _process(delta: float) -> void:
	time_alive += delta
	
	position += direction * velocity * delta
	
	gravity = gravity + (delta * gravity_modifier)
	gravity_modifier *= 1.05
	
	position.y += gravity * delta
	
	velocity -= velocity * air_resistance
	return
	
func set_facing (direction: int) -> void:
	self.direction = Vector2.RIGHT if direction >= 0 else Vector2.LEFT


func set_direction(new_direction: Vector2) -> void:
	if new_direction == Vector2.ZERO:
		return
	direction = new_direction.normalized()
	#rotation = direction.angle()	


func get_impact_damage() -> int:
	return roundi(damage * velocity * velocity_damage_multiplier)


func is_falling() -> bool:
	return direction.y * velocity + gravity > 0


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtboxes"):
		area.take_damage(get_impact_damage())
		queue_free()
	elif area.is_in_group("player_hurtboxes"):
		if time_alive < owner_collision_grace_time:
			return
		area.take_damage(get_impact_damage())
		queue_free()
