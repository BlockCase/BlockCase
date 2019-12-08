extends Node2D

var CHUNKSIZE = 100

signal re_cherk_move(cell, dir, jump, ncell)
signal move(dir)
signal re_check_buttonL0E()
signal re_check_buttonTutoL()

func _ready():
	
	for x in CHUNKSIZE:
		for y in CHUNKSIZE:
			if $TileMap.get_cell(x, y) == -1:
				$TileMap.set_cell(x,  y, 0)

func _on_KinematicBody2D_check_move(x, y, dir, jump):
	if !jump:
		if dir == 0:
			emit_signal("re_cherk_move", $TileMap.get_cell(x/64,y/64), dir, false, $TileMap.get_cell(x/64+1,y/64))
		elif dir == 2:
			emit_signal("re_cherk_move", $TileMap.get_cell(x/64,y/64), dir, false, $TileMap.get_cell(x/64-1,y/64))
		elif dir == 1:
			emit_signal("re_cherk_move", $TileMap.get_cell(x/64,y/64), dir, false, $TileMap.get_cell(x/64,y/64+1))
		elif dir == 3:
			emit_signal("re_cherk_move", $TileMap.get_cell(x/64,y/64), dir, false, $TileMap.get_cell(x/64,y/64-1))
	elif jump:
		if dir == 0:
			emit_signal("re_cherk_move", $TileMap.get_cell(x/64,y/64), dir, true, $TileMap.get_cell(x/64+1,y/64))
		elif dir == 2:
			emit_signal("re_cherk_move", $TileMap.get_cell(x/64,y/64), dir, true, $TileMap.get_cell(x/64-1,y/64))
		elif dir == 1:
			emit_signal("re_cherk_move", $TileMap.get_cell(x/64,y/64), dir, true, $TileMap.get_cell(x/64,y/64+1))
		elif dir == 3:
			emit_signal("re_cherk_move", $TileMap.get_cell(x/64,y/64), dir, true, $TileMap.get_cell(x/64,y/64-1))

func _on_KinematicBody2D_drag_object(x, y, dir):
	
	var rcell = $TileMap.get_cell(x/64+1, y/64)
	var rx = x+64
	var ry = y
	var dcell = $TileMap.get_cell(x/64, y/64+1)
	var dx = x
	var dy = y+64
	var lcell = $TileMap.get_cell(x/64-1, y/64)
	var lx = x-64
	var ly = y
	var ucell = $TileMap.get_cell(x/64, y/64-1)
	var ux = x
	var uy = y-64
	
	if rcell == 6:
		move(rx, ry, dir)
	elif dcell == 6:
		move(dx, dy, dir)
	elif lcell == 6:
		move(lx, ly, dir)
	elif ucell == 6:
		move(ux, uy, dir)

func move(x, y, dir):
	if dir == 0:
		if $TileMap.get_cell(x/64+1, y/64) == 4:
			$TileMap.set_cell(x/64, y/64, 0)
			$TileMap.set_cell(x/64+1, y/64, 5)
			emit_signal("move", dir)
		elif $TileMap.get_cell(x/64+1, y/64) == 0:
			$TileMap.set_cell(x/64, y/64, 0)
			$TileMap.set_cell(x/64+1, y/64, 6)
			emit_signal("move", dir)
	elif dir == 1:
		if $TileMap.get_cell(x/64, y/64+1) == 4:
			$TileMap.set_cell(x/64, y/64, 0)
			$TileMap.set_cell(x/64, y/64+1, 5)
			emit_signal("move", dir)
		elif $TileMap.get_cell(x/64, y/64+1) == 0:
			$TileMap.set_cell(x/64, y/64, 0)
			$TileMap.set_cell(x/64, y/64+1, 6)
			emit_signal("move", dir)
	elif dir == 2:
		if $TileMap.get_cell(x/64-1, y/64) == 4:
			$TileMap.set_cell(x/64, y/64, 0)
			$TileMap.set_cell(x/64-1, y/64, 5)
			emit_signal("move", dir)
		elif $TileMap.get_cell(x/64-1, y/64) == 0:
			$TileMap.set_cell(x/64, y/64, 0)
			$TileMap.set_cell(x/64-1, y/64, 6)
			emit_signal("move", dir)
	elif dir == 3:
		if $TileMap.get_cell(x/64, y/64-1) == 4:
			$TileMap.set_cell(x/64, y/64, 0)
			$TileMap.set_cell(x/64, y/64-1, 5)
			emit_signal("move", dir)
		elif $TileMap.get_cell(x/64, y/64-1) == 0:
			$TileMap.set_cell(x/64, y/64, 0)
			$TileMap.set_cell(x/64, y/64-1, 6)
			emit_signal("move", dir)


func _on_ButtonTutoL_check_player():
	if $Button/ButtonTutoL.position.x == $Player.position.x && $Button/ButtonTutoL.position.y == $Player.position.y:
		emit_signal("re_check_buttonTutoL")


func _on_ButtonTutoL_active():
	$Player.tuto = false
	$Player.die()


func _on_Player_TutoYes():
	$Player/Camera/CanvasLayer/Tuto.visible = false
	$Player.position.x = 30*64+32
	$Player.position.y = 3*64+32


func _on_Player_TutoNo():
	$Player/Camera/CanvasLayer/Tuto.visible = false


func _on_ButtonL0E_check_player():
	if $Button/ButtonL0E.position.x == $Player.position.x && $Button/ButtonL0E.position.y == $Player.position.y:
		emit_signal("re_check_buttonL0E")


func _on_ButtonL0E_active():
	$TileMap.set_cell(1, 8, 0)
	$TileMap.set_cell(2, 8, 0)
	$TileMap.set_cell(3, 8, 0)

