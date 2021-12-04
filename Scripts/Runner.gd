extends KinematicBody2D

export var speed := 100.0
export var jump_speed := 350.0
export var gravity := 20.0

var direction := Vector2.RIGHT
var velocity := Vector2.ZERO

var was_on_floor := true

var flipped_last_frame := false

onready var player_sensors := [$PlayerSensor1, $PlayerSensor2, $PlayerSensor3, $PlayerSensor4]


func _physics_process(_delta):
	var y = velocity.y
	velocity = speed * direction
	velocity.y = y

	velocity.y += gravity

	velocity = move_and_slide(velocity, Vector2.UP)

	if not is_on_floor() and was_on_floor:
		_force_jump()

	was_on_floor = is_on_floor()

	var new_direction

	for cast in player_sensors:
		if cast.get_collider() and cast.get_collider().is_in_group("player"):
			new_direction = -direction

	for i in get_slide_count():
		var x_normal = get_slide_collision(i).normal.x

		if x_normal == 1:
			new_direction = Vector2.RIGHT
		elif x_normal == -1:
			new_direction = Vector2.LEFT

	if new_direction and new_direction != direction:
		if flipped_last_frame:
			jump()

		flipped_last_frame = true

		direction = new_direction

		for cast in player_sensors:
			cast.scale.x = direction.x
	else:
		flipped_last_frame = false


func _process(_delta):
	$AnimatedSprite.flip_h = direction.x < 0

	if velocity.y < 0:
		$AnimatedSprite.play("jump")
	elif velocity.y > 0:
		$AnimatedSprite.play("fall")
	else:
		$AnimatedSprite.play("walk")


func left():
	direction = Vector2(-1, 0)


func right():
	direction = Vector2(1, 0)


func jump():
	if is_on_floor():
		_force_jump()


func _force_jump():
	velocity.y = -jump_speed
