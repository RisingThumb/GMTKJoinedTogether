extends Node

export(String) var path_tree_file
var path_tree_states

class State:
	var name: String
	var description: String
	var event_index: int
	
	var children: Array
	var ranges: Array
	
	func get_name():
		return name
	
	func get_description():
		return description
	
	func get_event_index():
		return event_index
		
	func get_children():
		return children
		
	func get_ranges():
		return ranges
		
	func _init(_name: String, _description: String, _event_index: int):
		name = _name
		description = _description
		event_index = _event_index
	
	func _set_children(_children: Array):
		children = _children
		
	func _set_ranges(_ranges: Array):
		ranges = _ranges

func get_next_state(state: State, discord: int) -> State:
	if state == null:
		return path_tree_states[0]
	
	var counter = 0
		
	for bounds in state.get_ranges():
		var lower_bound = bounds[0]
		var upper_bound = bounds[1]
		
		if discord >= lower_bound && discord <= upper_bound:
			return state.get_children()[counter]
		
		counter += 1
		
	return null
	
func _construct_tree(data):
	var states = []
	
	for object in data["states"]:
		states.push_back(State.new(object["name"], object["description"], object["event_index"]))
	
	for association in data["associations"]:
		var to = association["to"]
		var from = association["from"]
		
		var state = states[from]
		
		state.get_children().push_back(states[to])
		state.get_ranges().push_back(association["range"])
	
	return states

func _ready():
	var document = _load_file(path_tree_file)
	var parsed = JSON.parse(document)
	
	path_tree_states = _construct_tree(parsed.result)

func _load_file(name):
	var file = File.new()
	file.open(name, File.READ)
	
	var content = file.get_as_text()
	file.close()
	
	return content
