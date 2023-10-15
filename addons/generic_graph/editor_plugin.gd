@tool
extends EditorPlugin
class_name GenericGraphEditorPlugin

const graph_editor_prototype : PackedScene = preload("res://addons/generic_graph/editor/generic_graph_editor.tscn")

# Control Instance of the Graph Editor
var graph_editor : GenericGraphEditor

"""
Setup the Generic Graph Editor
"""

func _enter_tree() -> void:
	graph_editor = graph_editor_prototype.instantiate()
	add_control_to_bottom_panel(graph_editor, "Generic Graph")
	
func _exit_tree() -> void:
	remove_control_from_bottom_panel(graph_editor)
	graph_editor.queue_free()

func _make_visible(visible: bool) -> void:
	print("Make Visible")

func _edit(object: Object) -> void:
	if object is GenericGraph:
		graph_editor.start_editing_asset(object)
	
func _handles(object: Object) -> bool:
	if object is GenericGraph:
		return true
	return false
	
