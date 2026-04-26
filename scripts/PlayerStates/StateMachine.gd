class_name StateMachine extends Node

@export var initial_state: State
var currentState : State
var lock_transistions := false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# connect States 'finished' method to the handler: change_state from StateMachine
	for child_node: State in get_children():
		child_node.finished.connect(change_state)
	
	if initial_state:
		change_state (initial_state.name)
		return

	change_state((get_child (0) as State).name)

	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentState:
		currentState.handle_update()
	
func _physics_process(delta: float) -> void:
	if currentState:
		currentState.handle_physics(delta)
	return
	
func _unhandled_input(event: InputEvent) -> void:
	if currentState:
		currentState.handle_input()

func change_state (newState : String):
	if lock_transistions:
		print ("Transition locked.")
		return
	if newState.contains("Enemy"):
		print("NEW STATE: ", newState)
	if currentState:
		currentState.exit()
		
	currentState = get_node(newState)
	currentState.enter()
	return

func _on_enemy_hurt_hurt_finished() -> void:
	lock_transistions = false
