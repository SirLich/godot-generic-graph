@tool

extends MarginContainer

@onready var tree: Tree = $MarginContainer/VBoxContainer/Tree

func _enter_tree() -> void:
	print("CHILD ENTER TREE")

func _ready():
	print("OK")
	var root = tree.create_item()
	tree.hide_root = true
	var child1 = tree.create_item(root)
	var child2 = tree.create_item(root)
	var subchild1 = tree.create_item(child1)
	subchild1.set_text(0, "Subchild1")


func _on_tree_item_activated() -> void:
	pass # Replace with function body.
