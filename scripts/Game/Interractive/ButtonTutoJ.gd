extends Node

var activated = false

export(Array, NodePath) var targets_nodes = []

signal check_player()
signal active()

func _ready():
	pass

func _physics_process(delta):
	var use = Input.is_action_just_pressed("player_interaction_use")
	if use:
		emit_signal("check_player")
	if activated:
		$Sprite.frame = 10
	if !activated:
		$Sprite.frame = 9

func _on_Game_re_check_buttonTutoJ():
	if activated:
		activated = false
	elif !activated:
		activated = true
		emit_signal("active")
