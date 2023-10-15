@tool
extends EditorPlugin
class_name GenericGraphEditorPlugin

const graph_editor_prototype : PackedScene = preload("res://addons/generic_graph/editor/generic_graph_editor.tscn")

# Control Instance of the StepGraph Editor
var graph_editor : GenericGraphEditor

func _make_visible(visible: bool) -> void:
	print("Make Visible")
	
func _edit(object: Object) -> void:
	print("Hello World")
	print(object)
	if object is StepGraph:
		graph_editor.start_editing_asset(object)
	
func _handles(object: Object) -> bool:
	print(object)
	if object is StepGraph:
		return true
	return false
	
func _enter_tree() -> void:
	graph_editor = graph_editor_prototype.instantiate()
	add_control_to_bottom_panel(graph_editor, "Step Graph")
	
func _exit_tree() -> void:
	remove_control_from_bottom_panel(graph_editor)
	graph_editor.queue_free()
	
