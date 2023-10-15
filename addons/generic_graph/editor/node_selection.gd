@tool

extends MarginContainer

@onready var tree: Tree = $MarginContainer/VBoxContainer/Tree

func _enter_tree() -> void:
	print("CHILD ENTER TREE")
	
func _get_file_names_recursive(path) -> PackedStringArray:
	var out = []
	var dir = DirAccess.open(path)
	if not dir:
		return []
		
	for dir_name in dir.get_directories():
		var dir_path = path +  "/" + dir_name
		out.append_array(_get_file_names_recursive(dir_path))
	
	for file_name in dir.get_files():
		var file_path = path + "/" + file_name
		out.append(file_path)
	return out
	
func _build_tree(tree : Tree):
	for path in _get_file_names_recursive("res://"):
		if ResourceLoader.exists(path):
			var resource = ResourceLoader.load(path)
			if resource is GenericGraphNode:
				print("WOW")
				var child = tree.create_item()
				child.set_text(0, path.get_file())
	

	
func _ready():
	print("OK")
	var root = tree.create_item()
	tree.hide_root = true
	_build_tree(tree)
	

func _on_tree_item_activated() -> void:
	pass # Replace with function body.
