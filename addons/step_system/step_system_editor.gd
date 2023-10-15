@tool
extends EditorPlugin
class_name GenericGraphEditor

const step_graph_editor_pack = preload("res://addons/step_system/step_graph_editor_instance.tscn")

# Control Instance of the StepGraph Editor
var step_graph_editor : StepGraphEditor

func _make_visible(visible: bool) -> void:
	print("Make Visible")
	
func _edit(object: Object) -> void:
	print("Hello World")
	print(object)
	if object is StepGraph:
		step_graph_editor.start_editing_asset(object)
	
func _handles(object: Object) -> bool:
	print(object)
	if object is StepGraph:
		return true
	return false
	
func _enter_tree() -> void:
	step_graph_editor = step_graph_editor_pack.instantiate()
	add_control_to_bottom_panel(step_graph_editor, "Step Graph")
	
func _exit_tree() -> void:
	remove_control_from_bottom_panel(step_graph_editor)
	step_graph_editor.queue_free()
	
