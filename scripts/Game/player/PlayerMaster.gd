extends KinematicBody2D

var last_dir = 0
var jump_possible = true
var griped = false
var tuto = false
var has_tuto_choice = false
var level = 0
var score = 0

const CELL_SIZE = 64
const MOVE_TILE = [0, 5, 8, 9]
const JUMP_TILE = [0, 2, 3, 5, 7, 8, 9]
const DIE_TILE = [3, 4]

signal check_move(x, y, dir, jump)
signal drag_object(x, y, dir)
signal TutoNo()
signal TutoYes()

func _ready():
	$"."/Camera/CanvasLayer/Tuto.visible = true

func _physics_process(delta):
	
	if !has_tuto_choice:
		return
	
	var up = Input.is_action_just_pressed("player_mouvement_up")
	var down = Input.is_action_just_pressed("player_mouvement_down")
	var left = Input.is_action_just_pressed("player_mouvement_left")
	var right = Input.is_action_just_pressed("player_mouvement_right")
	
	var jump = Input.is_action_just_pressed("player_mouvement_jump")
	
	var grip = Input.is_action_just_pressed("player_interation_grip")
	
	var escape = Input.is_action_just_pressed("player_interaction_escape")
	
	if escape:
		get_tree().change_scene("res://scene/Menu/MainMenu.tscn")
	
	$Camera/CanvasLayer/Dir/X.text = "X : " + str($".".position.x/64+0.5)
	$Camera/CanvasLayer/Dir/Y.text = "Y : " + str($".".position.y/64+0.5)
	$Camera/CanvasLayer/Score.text = "Score : " + str(score)
	
	if !jump_possible:
		$Jump.text = "Jump : " + str(int($Timer.time_left))
	
	if grip:
		if !tuto:
			score += 4
		if griped:
			griped = false
			$Player.frame -= 1
		elif !griped:
			griped = true
			$Player.frame += 1
	
	if up && $".".position.y > CELL_SIZE:
		emit_signal("check_move", $".".position.x, $".".position.y-CELL_SIZE, 3, false)
	if down:
		emit_signal("check_move", $".".position.x, $".".position.y+CELL_SIZE, 1, false)
	if left && $".".position.x > CELL_SIZE:
		emit_signal("check_move", $".".position.x-CELL_SIZE, $".".position.y, 2, false)
	if right:
		emit_signal("check_move", $".".position.x+CELL_SIZE, $".".position.y, 0, false)
	if jump && !griped:
		if last_dir == 0:
			emit_signal("check_move", $".".position.x+CELL_SIZE, $".".position.y, 0, true)
		if last_dir == 1:
			emit_signal("check_move", $".".position.x, $".".position.y+CELL_SIZE, 1, true)
		if last_dir == 2:
			emit_signal("check_move", $".".position.x-CELL_SIZE, $".".position.y, 2, true)
		if last_dir == 3:
			emit_signal("check_move", $".".position.x, $".".position.y-CELL_SIZE, 3, true)
	


func repeat_me():
    print("Loop")


func start_Timer():
	$Timer.start(2)
	jump_possible = false


func _on_Timer_timeout():
	jump_possible = true
	$Jump.text = "Jump : Possible"


func _on_Node2D_re_cherk_move(cell, dir, jump, ncell):
	last_dir = dir
	if !jump:
		if DIE_TILE.has(cell):
			die()
		elif MOVE_TILE.has(cell) || cell == 6:
			if griped:
				if cell == 0 || cell == 5 || cell == 6:
					emit_signal("drag_object", $".".position.x, $".".position.y, dir)
			elif !griped && MOVE_TILE.has(cell):
				move(dir)
	elif jump:
		if MOVE_TILE.has(ncell):
			if cell != 4:
				if JUMP_TILE.has(cell):
					jump(dir)
		elif ncell == 3 || ncell == 4 || cell == 4:
			die()
		

func jump(dir):
	if jump_possible:
		if !tuto:
			score += 3
		if dir == 0:
			$".".position.x += CELL_SIZE*2
			start_Timer()
		elif dir == 1:
			$".".position.y += CELL_SIZE*2
			start_Timer()
		elif dir == 2 && $".".position.x > CELL_SIZE:
			$".".position.x -= CELL_SIZE*2
			start_Timer()
		elif dir == 3 && $".".position.y > CELL_SIZE:
			$".".position.y -= CELL_SIZE*2
			start_Timer()

func move(dir):
	if !tuto:
		score += 1
	if dir == 0:
		$".".position.x += CELL_SIZE
	elif dir == 1:
		$".".position.y += CELL_SIZE
	elif dir == 2:
		$".".position.x -= CELL_SIZE
	elif dir == 3:
		$".".position.y -= CELL_SIZE

func die():
	if !tuto:
		score += 5
		if level == 0:
			$".".position.x = 2*64+32
			$".".position.y = 2*64+32
		elif level == 1:
			$".".position.x = 2*64+32
			$".".position.y = 18*64+32
		elif level == 2:
			$".".position.x = 2*64+32
			$".".position.y = 28*64+32
	elif tuto:
		$".".position.x = 57*64+32
		$".".position.y = 3*64+32


func _on_Game_move(dir):
	move(dir)


func _on_YesButton_button_down():
	emit_signal("TutoYes")
	tuto = true
	has_tuto_choice = true


func _on_NoButton_button_down():
	emit_signal("TutoNo")
	has_tuto_choice = true

func add_score():
	score += 1

func launch():
	var timer = Timer.new()
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "add_score")
	add_child(timer)
	timer.start()
