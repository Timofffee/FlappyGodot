extends Node2D

var score = 0
var tube = preload("res://tube.tscn")
var playing = true
var kill = false
var can_restart = false

func _ready():
	set_process(true)

func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		_on_Button_pressed()

func is_playing():
	return playing

func _on_start_time_timeout():
	get_node("tubes").add_child(tube.instance())

func _on_Button_pressed():
	get_node("LOGO").hide()
	get_node("label").set_text(str(score))
	set_process(false)
	get_node("tubes").add_child(tube.instance())
	get_node("start_time").start()
	get_node("player").set_sleeping(false)

func add_score():
	score += 1
	get_node("label").set_text(str(score))

func kill():
	if not kill:
		kill = true
		get_node("dead_timer").start()
		get_node("flash/anim").play("flash")
		playing = false
		get_node("ground/anim").stop()
		get_node("label").set_text("\nYOU LOSE\n\nYOUR SCORE:\n"+str(score))

func kill_ground(body):
	
	get_node("player").set_sleeping(true)
	kill()

func has_restart():
	return can_restart


func _on_dead_timer_timeout():
	can_restart = true
