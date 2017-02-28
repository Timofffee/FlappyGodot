extends Node2D

var score = 0
var tube = preload("res://tube.tscn")
var playing = true
var kill = false
var can_restart = false

onready var logo = get_node("LOGO")
onready var label = get_node("label")
onready var tubes = get_node("tubes")
onready var start_time = get_node("start_time")
onready var player = get_node("player")
onready var dead_timer = get_node("dead_timer")
onready var flash_anim = get_node("flash/anim")
onready var ground_anim = get_node("ground/anim")

# uncomment, if Godot < 2.2+
#var press_button = false

func _ready():
	set_process(true)

func _process(delta):
# uncomment, if Godot < 2.2+
#	if not press_button and Input.is_action_pressed("ui_accept"):
#		_on_Button_pressed()
#	press_button = Input.is_action_pressed("ui_accept")
	
# comment out the two lines below, if Godot < 2.2+	
	if (Input.is_action_just_pressed("ui_accept")):
		_on_Button_pressed()

func is_playing():
	return playing

func _on_start_time_timeout():
	tubes.add_child(tube.instance())

func _on_Button_pressed():
	logo.hide()
	label.set_text(str(score))
	set_process(false)
	tubes.add_child(tube.instance())
	start_time.start()
	player.set_sleeping(false)

func add_score():
	score += 1
	label.set_text(str(score))

func kill():
	if not kill:
		kill = true
		dead_timer.start()
		flash_anim.play("flash")
		playing = false
		ground_anim.stop()
		label.set_text("\nYOU LOSE\n\nYOUR SCORE:\n"+str(score))

func kill_ground(body):
	player.set_sleeping(true)
	kill()

func has_restart():
	return can_restart


func _on_dead_timer_timeout():
	can_restart = true
