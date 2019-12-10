extends Button

var over = false

var max_size = 400
var speed = 2000

func _ready():
	pass

func _process(delta):
	if over && $".".rect_size.x <= max_size:
		$".".rect_size = Vector2($".".rect_size.x + (speed*delta),$".".rect_size.y)
	elif over && $".".rect_size.x >= max_size-20:
		$".".text = "Options"
	elif !over && $".".rect_size.x > 128:
		$".".rect_size = Vector2($".".rect_size.x - (speed*delta),$".".rect_size.y)
	elif !over && $".".rect_size.x < 128:
		$".".rect_size.x = 128

func _on_OptionButton_mouse_entered():
	over = true


func _on_OptionButton_mouse_exited():
	over = false
	$".".text = ""


func _on_OptionButton_pressed():
	over = false
	$".".text = ""
