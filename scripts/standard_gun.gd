class_name StandardGun extends Weapon

@export var bullet_scene_to_preload : PackedScene
@export var damage : int


func shoot (origin : Vector2, direction : Vector2) -> void:
	spawn_projectile.emit(bullet_scene_to_preload, origin, direction, damage)
	return


signal spawn_projectile (bullet_scene : PackedScene, origin : Vector2, direction: Vector2, damage: int)
