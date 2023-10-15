@tool

class_name GenericGraphEdit extends GraphEdit

@export var selector_prototype : PackedScene
@onready var title: Label = $HBoxContainer/Title

signal request_exit(generic_graph)
signal request_save(generic_graph)

const NO_GRAPH_TEXT = "NO GRAPH SELECTED"
# The selection widget, if active
var selector : GenericGraphNodeSelection
# The Graph that's currently being edited.
var generic_graph : GenericGraph
	
func _ready() -> void:
	title.text = generic_graph.name
	
func is_graph_valid():
	return generic_graph != null
	
func _is_left_click(event):
	return event is InputEventMouseButton and event.button_index == 1

func _on_popup_request(position: Vector2) -> void:
	spawn_selector()

# Called via signal (bound)
func on_node_created(graph_node):
	self.add_child(graph_node)
	
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
	request_save.emit(generic_graph)

func _on_exit_button_button_up() -> void:
	request_exit.emit(generic_graph)
