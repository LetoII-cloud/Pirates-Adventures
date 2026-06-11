class_name DialogManager extends Control

signal dialogue_closed

@onready var speaker_label: Label = $Panel/DialogRect/Speaker
@onready var dialogue_label: RichTextLabel = $Panel/DialogRect/Dialogue
@onready var next_button: Button = $Panel/NextButton

var entries: Array
var current_line_index := 0
var current_entry_index := 0


func _ready() -> void:
	visible = false
	next_button.pressed.connect(_on_next_button_pressed)

func show_dialogue(entries : Array) -> void:
	self.entries = entries
	var contents: Array[String] = []	
	var speaker := str(entries[current_entry_index].get("speaker"))
	
	if entries.is_empty():
		hide_dialogue()
		return

	speaker_label.text = speaker
	current_line_index = 0
	_show_current_line()
	visible = true
	get_tree().paused = true

func hide_dialogue() -> void:
	visible = false
	current_line_index = 0
	current_entry_index = 0
	get_tree().paused = false
	dialogue_closed.emit()

func advance_dialogue() -> void:

	if current_line_index >= entries[current_entry_index]["lines"].size() - 1:
		current_line_index = 0
		current_entry_index += 1
		if current_entry_index > entries.size() - 1:
			hide_dialogue()
			return
		_show_current_line()
	else:
		current_line_index += 1
		_show_current_line()
		

func _show_current_line() -> void:
	speaker_label.text = entries[current_entry_index]["speaker"]
	dialogue_label.text = entries[current_entry_index]["lines"][current_line_index]
	next_button.text = "Close" if current_entry_index >= entries.size()-1 and current_line_index >= entries[current_entry_index]["lines"].size() - 1 else "Next"

func _on_next_button_pressed() -> void:
	advance_dialogue()
