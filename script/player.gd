extends RigidBody2D

onready var sprite = get_node("Sprite")
onready var jump_sound = get_node("jump")
var current_scene

func _ready():
	sprite.set_rotd(0.0)
	current_scene = get_tree().get_current_scene()
	set_process_input(true)
	set_process(true)

func _input(ev):
	if ev.type == InputEvent.SCREEN_TOUCH:
		if ev.is_pressed():
			jump()

func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		jump()
	if not is_sleeping():
#		sprite.set_rot(Vector2(-100,0).angle_to_point(get_linear_velocity())+deg2rad(90))
		var vel = get_linear_velocity().y
		if vel < 500:
			sprite.set_rotd(lerp(sprite.get_rotd(), 15.0, 20.0*delta))
		elif vel > 500:
			sprite.set_rotd(lerp(sprite.get_rotd(), -90.0, 5.0*delta))

func jump():
	if not is_sleeping() and current_scene.is_playing():
		if (get_pos().y > 0):
			set_linear_velocity(Vector2(0,-500))
#			set_linear_velocity(Vector2(0,0))
#			apply_impulse(Vector2(0,0),Vector2(0,-9000))
			jump_sound.play()
	else:
		if (current_scene.has_restart()):
			get_tree().change_scene("res://scene/main.tscn")
