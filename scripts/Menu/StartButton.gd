extends Button

var over = false

var max_size = 510
var speed = 2000

func _ready():
	pass

func _on_StartButton_pressed():
	over = false
	$".".text = ""
	get_tree().change_scene("res://scene/Game/GameMaster.tscn")

func _process(delta):
	if over && $".".rect_size.x <= max_size:
		$".".rect_size = Vector2($".".rect_size.x + (speed*delta),$".".rect_size.y)
	elif over && $".".rect_size.x >= max_size-20:
		$".".text = "Start Game"
	elif !over && $".".rect_size.x > 128:
		$".".rect_size = Vector2($".".rect_size.x - (speed*delta),$".".rect_size.y)
	elif !over && $".".rect_size.x < 128:
		$".".rect_size.x = 128

func _on_StartButton_mouse_entered():
	over = true


func _on_StartButton_mouse_exited():
	over = false
	$".".text = ""
