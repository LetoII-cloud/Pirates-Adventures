class_name LevelManager extends Node

const LEVELS := {
	"Level1": preload("res://scenes/Level1.tscn"),
	"Level2": preload("res://scenes/Level2.tscn"),
}
@export var current_level_name : String
@export var dialog_manager_path : NodePath

@onready var dialog_manager : DialogManager = get_node(dialog_manager_path)
var current_level : Level

var dialogues : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch_level(current_level_name)

func switch_level (level_name : String) -> void:
	current_level_name = level_name
	if current_level != null:
		remove_current_level()
	var target_level_name = current_level_name if (current_level_name != null and current_level_name != '') else "Level1"
	var current_level_packed_scene : PackedScene = LEVELS[target_level_name]
	current_level = current_level_packed_scene.instantiate()
	add_child(current_level)
	current_level.dialogue_requested.connect(play_dialogue)
	if current_level.exit != null:
		current_level.exit.level_complete.connect(switch_level)
	load_dialogues(target_level_name)

func remove_current_level ():
	current_level.queue_free()
	current_level = null
	
func load_dialogues (level : String) -> void:
	var dialogue_reader : FileReader = FileReader.new()
	var file_path : String = "res://assets/dialogues/%s.json" % level
	var dialogues_raw := dialogue_reader.read_file(file_path)
	var json = JSON.new()
	var error = json.parse(dialogues_raw)
	if error == OK:
		var data_received = json.data
		dialogues = data_received["dialogues"]
	else:
		dialogues.clear()
		push_error("Failed to parse dialogue file %s at line %s: %s" % [
			file_path,
			json.get_error_line(),
			json.get_error_message(),
		])

func play_dialogue(dialogue_id : String) -> void:
	if not dialogues.has(dialogue_id):
		push_warning("Unknown dialogue id: %s" % dialogue_id)
		return

	var entries: Variant = dialogues[dialogue_id]
	#if typeof(entry) != TYPE_DICTIONARY:
	#	push_warning("Dialogue entry %s is not a dictionary." % dialogue_id)
	#	return

	if entries.is_empty():
		push_warning("Dialogue %s has no lines." % dialogue_id)
		return

	dialog_manager.show_dialogue(entries)
