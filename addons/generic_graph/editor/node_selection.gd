@tool

extends MarginContainer

@onready var tree: Tree = $MarginContainer/VBoxContainer/Tree

func _enter_tree() -> void:
	print("CHILD ENTER TREE")

func _build_tree(root):
	var out_resources = []
	var dir = DirAccess.open("res://")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		var resource = ResourceLoader.load(file_name)
		if resource != null and resource is GenericGraphNode:
			var child = root.create_item(root)
			child.set_text(0, file_name)
			out_resources.append(resource)
		file_name = dir.get_next()
	

	
func _ready():
	print("OK")
	var root = tree.create_item()
	tree.hide_root = true
	_build_tree(root)

func _on_tree_item_activated() -> void:
	pass # Replace with function body.
