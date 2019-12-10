extends Node2D

func _ready():
	pass


func _on_OptionButton_pressed():
	$MainMenu.visible = false
	$OptionMenu.visible = true


func _on_ReturnButton_pressed():
	$MainMenu.visible = true
	$OptionMenu.visible = false
