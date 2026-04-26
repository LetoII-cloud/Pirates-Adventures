class_name State extends Node

func enter () -> void:
	pass

func exit () -> void:
	pass
	
func handle_input () -> void:
	pass
	
func handle_update () -> void:
	pass

func handle_physics (delta: float) -> void:
	pass
	
signal finished (nextState : String, data : Dictionary)
