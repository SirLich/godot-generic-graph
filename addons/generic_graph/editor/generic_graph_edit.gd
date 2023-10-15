@tool

class_name GenericGraphEdit extends GraphEdit

@export var selector_prototype : PackedScene
@onready var title: Label = $GraphEditContainer/GraphEdit/HBoxContainer/Title
@onready var graph_edit: GraphEdit = %GraphEdit
@onready var no_graph_label: Label = $GraphEditContainer/NoGraphLabel

const NO_GRAPH_TEXT = "NO GRAPH SELECTED"
# The selection widget, if active
var selector : GenericGraphNodeSelection
# The Graph that's currently being edited.
var generic_graph : GenericGraph
	
func _ready() -> void:
	_evaluate_rendering()
	title.text = NO_GRAPH_TEXT
	
func _evaluate_rendering():
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


func _on_popup_request(position: Vector2) -> void:
	spawn_selector()
	
func save_graph():
	# TODO implement this
	pass
	
func stop_editing_asset():
	save_graph()
	generic_graph = null
	title.text = NO_GRAPH_TEXT
	
func start_editing_asset(generic_graph_ : GenericGraph):
	generic_graph = generic_graph_
	title.text = generic_graph.name
	_evaluate_rendering()

# Called via signal (bound)
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
		
func _on_save_button_button_up() -> void:
	save_graph()

func _on_close_button_button_up() -> void:
	stop_editing_asset()
	
# Local Functions

