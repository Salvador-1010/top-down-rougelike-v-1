extends Node
class_name StateMachine

#export varaible to default to a specfici initial state (most likely idle)
@export var initialState: State

#variable to store the current active state
var currentState : State
#variable to store all of the states of the machine
var states : Dictionary = {}
#creates a reference to the player node in order to give it to all the children to access
var playerRef : CharacterBody2D

func _ready() -> void:
	playerRef = get_parent() as CharacterBody2D
	for child in get_children():
		if child is State:
			#adds all the children state to a dictionary for storage
			states[child.name.to_lower()] = child
			#connects all of the childrens tranisiton functions 
			child.Transitioned.connect(on_child_transition)
			#gives all the children a reference to the player node (for sprite/physics updating)
			child.entity = playerRef
			
	if initialState:
		#sets the current active state to whatever the initial state was (if given one)
		currentState = initialState
		#does not actually ENTER the initial state until the player "onready" vars are ready
		call_deferred("_enter_initial_state")
			
func _process(delta: float) -> void:
	if currentState:
		currentState.update(delta)
	
func _physics_process(delta: float) -> void:
	if currentState:
		currentState.physics_update(delta)

func on_child_transition(state : State, new_state_name) -> void:
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

func _enter_initial_state() -> void:
	currentState.enter()
