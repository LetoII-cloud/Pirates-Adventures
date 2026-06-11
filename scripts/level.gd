class_name Level extends Node

@export var level_name : String

@onready var exit := $Exit

@onready var enemies : Array[Enemy]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Enemy:
			enemies.append(child)
			child.dialogue_requested.connect(show_dialogue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_dialogue (dialogue_id : String) -> void:
	dialogue_requested.emit(dialogue_id)
	
signal dialogue_requested (dialogue_id : String)
