extends Button

var over = false

var max_size = 500
var speed = 2000

func _ready():
	pass

func _on_QuitButton_pressed():
	over = false
	$".".text = ""
	get_tree().quit()

func _process(delta):
	if over && $".".rect_size.x <= max_size:
		$".".rect_size = Vector2($".".rect_size.x + (speed*delta),$".".rect_size.y)
	elif over && $".".rect_size.x >= max_size-20:
		$".".text = "Quit Game"
	elif !over && $".".rect_size.x > 128:
		$".".rect_size = Vector2($".".rect_size.x - (speed*delta),$".".rect_size.y)
	elif !over && $".".rect_size.x < 128:
		$".".rect_size.x = 128

func _on_QuitButton_mouse_entered():
	over = true


func _on_QuitButton_mouse_exited():
	over = false
	$".".text = ""
