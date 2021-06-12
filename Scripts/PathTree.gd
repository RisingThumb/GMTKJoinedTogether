extends Node

export(String) var path_tree_file
var root_path_tree_state

class State:
	var name: String
	var description: String
	
	var children: Array
	var thresholds: Array
	
	func get_name():
		return name
		
	func get_description():
		return description
	
	func get_children():
		return children
		
	func get_thresholds():
		return thresholds
		
	func _init(_name: String, _description: String):
		name = _name
		description = _description
	
	func _set_children(_children: Array):
		children = _children
		
	func _set_thresholds(_thresholds: Array):
		thresholds = _thresholds
		
func _construct_tree(data):
	var states = []
	
	for object in data["states"]:
		states.push_back(State.new(object["name"], object["description"]))
	
	for association in data["associations"]:
		var to = association["to"]
		var from = association["from"]
		
		var children = states[from].get_children()
		children.push_back(states[to])
	
	return states[0]

func _ready():
	var document = _load_file(path_tree_file)
	var parsed = JSON.parse(document)
	
	root_path_tree_state = _construct_tree(parsed.result)

func _load_file(name):
	var file = File.new()
	file.open(name, File.READ)
	
	var content = file.get_as_text()
	file.close()
	
	return content
