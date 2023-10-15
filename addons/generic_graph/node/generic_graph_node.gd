@tool

class_name GenericGraphNode extends Resource

@export var name : String
@export var slots : Array[GenericGraphSlot]

# Generates the graph node which will be placed into the graph
func create_graph_node() -> GraphNode:
	var node := GraphNode.new()
	node.title = name
	node.size = Vector2(200, 70)
	# Add slots
	for i in slots.size():
		node.add_child(Control.new())
		
		var slot := slots[i]
		node.set_slot(i, slot.left_enabled, slot.left_type, slot.left_color, slot.right_enabled, slot.right_type, slot.right_color, slot.left_icon, slot.right_icon, slot.draw_stylebox)
	
	return node
	
