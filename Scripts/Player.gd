extends KinematicBody2D

export var friction = 0.5
export var max_speed = 250
export var acceleration_speed = 100
export var jump_speed = 500
export var gravity = 25

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO


func _process(_delta):
	_apply_friction()
	_get_acceleration()
	_jump()
	_apply_gravity()
	_update_velocity()
	_apply_velocity()


func _apply_friction():
	velocity.x *= friction


func _get_acceleration():
	acceleration = Vector2.ZERO

	if Input.is_action_pressed("left"):
		acceleration.x += -acceleration_speed * acceleration_speed

	if Input.is_action_pressed("right"):
		acceleration.x += acceleration_speed * acceleration_speed


func _jump():
	if Input.is_action_just_pressed("up") and is_on_floor():
		acceleration.y = -jump_speed


func _apply_gravity():
	acceleration.y += gravity


func _update_velocity():
	velocity += acceleration
	velocity.x = clamp(velocity.x, -max_speed, max_speed)


func _apply_velocity():
	velocity = move_and_slide(velocity, Vector2.UP, true)
