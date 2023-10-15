@tool
extends Control
class_name GenericGraphEditor

@export var selector_prototype : PackedScene
@onready var title: Label = $GraphEditContainer/GraphEdit/Title
@onready var graph_edit: GraphEdit = %GraphEdit
@onready var no_graph_label: Label = $GraphEditContainer/NoGraphLabel

# The selection widget, if active
var selector : GenericGraphNodeSelection
# The Graph that's currently being edited.
var generic_graph : GenericGraph


func _ready() -> void:
	evaluate_rendering()
	
func start_editing_asset(generic_graph_ : GenericGraph):
	generic_graph = generic_graph_
	title.text = generic_graph.name
	evaluate_rendering()
	
func _on_graph_edit_popup_request(position: Vector2) -> void:
	spawn_selector()

func on_node_created(graph_node):
	graph_edit.add_child(graph_node)
	
func spawn_selector():
	despawn_selector()
	selector = selector_prototype.instantiate()
	self.add_child(selector)
	selector.global_position = get_global_mouse_position()
	selector.on_node_created.connect(on_node_created)
	
func despawn_selector():
	if selector != null:
		selector.queue_free()
	
func _on_graph_edit_gui_input(event: InputEvent) -> void:
	if _is_left_click(event):
		despawn_selector()

func evaluate_rendering():
	if is_graph_valid():
		print("Is Valid")
		no_graph_label.visible = false
		graph_edit.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		print("Is Not Valid")
		no_graph_label.visible = true
		graph_edit.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
func is_graph_valid():
	return generic_graph != null
	
func _is_left_click(event):
	return event is InputEventMouseButton and event.button_index == 1
