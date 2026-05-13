class_name LevelManager extends Node

const LEVELS := {
	"Level1": preload("res://scenes/Level1.tscn"),
	"Level2": preload("res://scenes/Level2.tscn"),
}
@export var current_level_name : String

var current_level : Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch_level(current_level_name) # jak tu zrobic dynamicznie
	pass

func switch_level (level_name : String) -> void:
	current_level_name = level_name
	print ('switching lvl')
	if current_level != null:
		remove_current_level()
	var target_level_name = current_level_name if (current_level_name != null and current_level_name != '') else "Level1"
	print ('cirremt ma', target_level_name)
	var current_level_packed_scene : PackedScene = LEVELS[target_level_name]
	current_level = current_level_packed_scene.instantiate()
	add_child(current_level)
	if current_level.exit != null:
		print('jush')
		current_level.exit.level_complete.connect(switch_level) # jak to zapewnic?
	print('adding child!')

func remove_current_level ():
	current_level.queue_free()
	current_level = null
	pass

signal level_ready (current_lvl : Level)
signal switch_level_call ()
