extends KinematicBody2D

export var speed := 100.0
export var jump_speed := 350.0
export var gravity := 20.0

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO


func _physics_process(_delta):
	var y = velocity.y
	velocity = speed * direction
	velocity.y = y

	velocity.y += gravity

	velocity = move_and_slide(velocity, Vector2.UP)


func left():
	direction = Vector2(-1, 0)


func right():
	direction = Vector2(1, 0)


func jump():
	if is_on_floor():
		velocity.y = -jump_speed
