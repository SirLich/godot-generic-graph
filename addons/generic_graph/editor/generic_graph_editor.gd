@tool
extends Control
class_name GenericGraphEditor

@onready var generic_graph_edit_prototype = preload("res://addons/generic_graph/editor/generic_graph_edit.tscn")
@onready var graph_edit_container: Control = $GraphEditContainer

var editors : Dictionary = {} # GenericGraph : GenericGraphEdit

func close_editor():
	if graph_edit_container.get_child_count() > 0:
		graph_edit_container.remove_child(graph_edit_container.get_child(0))
	
func open_editor(editor):
	# TODO: Should this save?
	close_editor()
		
	# Create new editor
	graph_edit_container.add_child(editor)

func on_request_exit(generic_graph):
	close_editor()
	
# Called when a new asset begins being edited.
func start_editing_asset(generic_graph : GenericGraph):
	# Create new editor if it doesn't exist
	if not editors.has(generic_graph):
		# TODO: Replace this with a getter into the generic_graph!
		var new_editor : GenericGraphEdit = generic_graph_edit_prototype.instantiate()
		editors[generic_graph] = new_editor
		new_editor.generic_graph = generic_graph
		new_editor.request_exit.connect(on_request_exit)
		
	open_editor(editors.get(generic_graph))
