extends Area2D

signal clicked

func _ready():
	pass
	
func _on_NoArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("clicked")


func _on_NoArea2D_mouse_entered():
	$ColorRect.color = Color(0.313726, 0.290196, 0.290196)


func _on_NoArea2D_mouse_exited():
	$ColorRect.color = Color(0.152941, 0.145098, 0.145098)