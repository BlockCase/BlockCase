extends Button

func _ready():
	pass

func _on_StartButton_pressed():
	get_tree().change_scene("res://scene/Game/GameMaster.tscn")
