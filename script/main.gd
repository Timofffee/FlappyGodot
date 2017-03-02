extends Node2D

var score = 0
var tube = preload("res://scene/tube.tscn")
var playing = false
var kill = false
var can_restart = false
var pressed = false
var tube_half_w = 0

export (int, 0, 64) var tube_count = 2

onready var logo = get_node("LOGO")
onready var label = get_node("label")
onready var tubes = get_node("tubes")
onready var start_time = get_node("start_time")
onready var player = get_node("player")
onready var dead_timer = get_node("dead_timer")
onready var flash_anim = get_node("flash/anim")
onready var ground_anim = get_node("ground/anim")
onready var kill_sound = get_node("kill")

func _ready():
	set_process_input(true)
	set_process(true)

func _input(ev):
	if ev.type == InputEvent.SCREEN_TOUCH:
		if not pressed:			#touch
			pressed = true
			_on_Button_pressed()
		else:					#untouch
			pressed = false


func _process(delta):
	if playing:
		var tubes_ch = tubes.get_children()
		if tubes_ch.size() > 0:
			if tubes_ch.size() == tube_count:
				set_process(false)
			else:
				if tubes_ch.back().get_pos().x < OS.get_window_size().x - (OS.get_window_size().x/tube_count) - tube_half_w:
					tubes.add_child(tube.instance()) #spawn other tube
	elif (Input.is_action_just_pressed("ui_accept")):
		_on_Button_pressed()

func is_playing():
	return playing

func _on_start_time_timeout():
	var t = tube.instance()
	tube_half_w = t.tube_wight/2
	tubes.add_child(t) #spawn first tube

func _on_Button_pressed():
	playing = true
	logo.hide()
	label.set_text(str(score))
	set_process_input(false)
	start_time.start()
	player.set_sleeping(false)
	player.jump()

func add_score():
	if not kill:
		score += 1
		label.set_text(str(score))

func kill():
	if not kill:
		kill = true
		dead_timer.start()
		flash_anim.play("flash")
		playing = false
		set_process(false)
		ground_anim.stop()
		label.set_text("\nYOU LOSE\n\nYOUR SCORE:\n"+str(score))
		kill_sound.play()

func kill_ground(body):
	player.set_sleeping(true)
	kill()

func has_restart():
	return can_restart

func _on_dead_timer_timeout():
	can_restart = true
