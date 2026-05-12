class_name Aiming extends Node2D

@onready var crosshair = $Crosshair

var is_aiming := false
var direction : Vector2 = Vector2.RIGHT

func _process(_delta: float) -> void:
	is_aiming = Input.is_action_pressed("aim")
	crosshair.visible = is_aiming
	if is_aiming:
		crosshair.global_position = get_global_mouse_position()
		direction = (crosshair.global_position - global_position).normalized()
