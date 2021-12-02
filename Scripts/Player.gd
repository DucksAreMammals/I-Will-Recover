extends KinematicBody2D

export var friction := 0.5
export var max_speed := 100.0
export var acceleration_speed := 25.0
export var jump_speed := 350.0
export var gravity := 20.0
export var snapping_distance := 10.0

var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO
var snapping := Vector2.DOWN
var jumping := false
var facing_right := true


func _physics_process(_delta):
	_apply_friction()
	_get_acceleration()
	_jump()
	_set_snapping()
	_apply_gravity()
	_update_velocity()
	_apply_velocity()
	_apply_animation()


func _apply_friction():
	velocity.x *= friction

	if get_floor_normal().x != 0 and get_floor_normal().y != 0:
		velocity.x = 0


func _get_acceleration():
	acceleration = Vector2.ZERO

	if Input.is_action_pressed("left"):
		acceleration.x += -acceleration_speed * acceleration_speed
		facing_right = false

	if Input.is_action_pressed("right"):
		acceleration.x += acceleration_speed * acceleration_speed
		facing_right = true


func _jump():
	if Input.is_action_just_pressed("up") and is_on_floor():
		acceleration.y = -jump_speed
		jumping = true
	elif is_on_floor():
		jumping = false


func _set_snapping():
	snapping = Vector2.ZERO if jumping else Vector2.DOWN


func _apply_gravity():
	acceleration.y += gravity


func _update_velocity():
	velocity += acceleration
	velocity.x = clamp(velocity.x, -max_speed, max_speed)


func _apply_velocity():
	velocity = move_and_slide_with_snap(velocity, snapping * snapping_distance, Vector2.UP, true)


func _apply_animation():
	$AnimatedSprite.flip_h = not facing_right

	if velocity.y > 0:
		$AnimatedSprite.play("fall")
	elif velocity.y < 0:
		$AnimatedSprite.play("jump")
	elif abs(velocity.x) <= .1:
		$AnimatedSprite.play("idle")
	else:
		$AnimatedSprite.play("walk")
