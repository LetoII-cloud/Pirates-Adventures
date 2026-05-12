extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn (bullet_scene : PackedScene, origin : Vector2, direction : Vector2, damage : int) -> void:
	var bullet : Bullet = bullet_scene.instantiate()
	bullet.global_position = origin
	bullet.damage = damage
	bullet.set_direction(direction)
	add_child(bullet)
