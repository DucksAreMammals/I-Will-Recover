extends KinematicBody2D

export var friction := 0.5
export var max_speed := 100.0
export var acceleration_speed := 25.0
export var jump_speed := 350.0
export var gravity := 20.0
export var snapping_distance := 10.0
export var coyote_time := 100.0

var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO
var snapping := Vector2.DOWN
var jumping := false
var grounded_time := INF
var grounded_y := 0.0
var facing_right := true
var stuck_raycasts

onready var level = get_parent()


func _ready():
	stuck_raycasts = [$StuckRay1, $StuckRay2, $StuckRay3, $StuckRay4]


func _physics_process(_delta):
	_apply_friction()
	_get_acceleration()
	_set_grounded_time()
	_jump()
	_set_snapping()
	_apply_gravity()
	_update_velocity()
	_apply_velocity()
	_collide()
	_apply_animation()
	_unstick()


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


func _set_grounded_time():
	if is_on_floor():
		grounded_time = OS.get_ticks_msec()
		grounded_y = position.y


func _jump():
	if Input.is_action_just_pressed("up") and grounded_time + coyote_time > OS.get_ticks_msec():
		position.y = grounded_y
		velocity.y = 0
		acceleration.y = -jump_speed
		jumping = true
	else:
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


func _collide():
	for i in get_slide_count():
		if get_slide_collision(i).collider.is_in_group("hurt"):
			die()


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


func die():
	position = level.get_respawn_point()


func _unstick():
	for stuck_raycast in stuck_raycasts:
		if not stuck_raycast.is_colliding():
			return

	die()


func set_vignette(material):
	$Vignette.material = material
