extends Node
class_name StateMachine

#export varaible to default to a specfici initial state (most likely idle)
@export var initialState: State

#variable to store the current active state
var currentState : State
#variable to store all of the states of the machine
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			
	if initialState:
		initialState.enter()
		currentState = initialState
			
func _process(delta: float) -> void:
	if currentState:
		currentState.update(delta)
	
func _physics_process(delta: float) -> void:
	if currentState:
		currentState.physics_update(delta)

func on_child_transition(state, new_state_name) -> void:
	print("trans")
	#checks to make sure the active state IS the one who called tranisitoned
	if state != currentState:
		return
	
	#gets the new state from the dictionary and checks that it is valid
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	#exits the current state if there is one then enters new one
	if currentState:
		currentState.exit()
	new_state.enter()
	currentState = new_state
