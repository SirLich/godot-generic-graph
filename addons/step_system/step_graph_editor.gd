@tool
extends Control
class_name StepGraphEditor

@export var step_selection_prototype : PackedScene
@onready var title: Label = $MarginContainer/GraphEdit/Title
@onready var graph_edit: GraphEdit = $MarginContainer/GraphEdit
@onready var margin_container: MarginContainer = $MarginContainer

var step_selection : Control

func start_editing_asset(step_graph : StepGraph):
	title.text = step_graph.name

func is_left_click(event):
	return event is InputEventMouseButton and event.button_index == 1
	
func _on_graph_edit_popup_request(position: Vector2) -> void:
	print("POPUP REQUEST")
	spawn_selector()

func spawn_selector():
	despawn_selector()
	step_selection = step_selection_prototype.instantiate()
	self.add_child(step_selection)
	print(position)
	step_selection.global_position = get_global_mouse_position()
	
func despawn_selector():
	if step_selection:
		step_selection.queue_free()
	
func _on_graph_edit_gui_input(event: InputEvent) -> void:
	if is_left_click(event):
		print("LEFT CLICK")
		despawn_selector()
