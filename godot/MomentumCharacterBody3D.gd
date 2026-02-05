extends CharacterBody3D

@export var max_speed := 16.0
@export var acceleration := 48.0
@export var deceleration := 32.0
@export var air_acceleration := 16.0
@export var air_control := 0.55
@export var gravity := 32.0
@export var jump_velocity := 12.0
@export var turn_sharpness := 8.0

var input_dir := Vector3.ZERO

func _physics_process(delta: float) -> void:
	_read_input()
	_apply_gravity(delta)
	_apply_momentum(delta)
	_handle_jump()
	move_and_slide()


func _read_input() -> void:
	var x := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var z := Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	input_dir = Vector3(x, 0.0, z)
	if input_dir.length() > 1.0:
		input_dir = input_dir.normalized()


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta


func _apply_momentum(delta: float) -> void:
	var target_speed := max_speed
	var target_velocity := input_dir * target_speed
	var current_horizontal := Vector3(velocity.x, 0.0, velocity.z)

	if is_on_floor():
		if input_dir.length() > 0.0:
			current_horizontal = current_horizontal.move_toward(
				target_velocity,
				acceleration * delta
			)
		else:
			current_horizontal = current_horizontal.move_toward(
				Vector3.ZERO,
				deceleration * delta
			)
	else:
		var air_target := target_velocity * air_control
		current_horizontal = current_horizontal.move_toward(
			air_target,
			air_acceleration * delta
		)

	current_horizontal = _apply_turn_sharpness(current_horizontal, target_velocity, delta)

	velocity.x = current_horizontal.x
	velocity.z = current_horizontal.z


func _apply_turn_sharpness(
	current_horizontal: Vector3,
	target_velocity: Vector3,
	delta: float
) -> Vector3:
	if target_velocity == Vector3.ZERO:
		return current_horizontal

	var current_dir := current_horizontal.normalized()
	var target_dir := target_velocity.normalized()

	if current_horizontal.length() == 0.0:
		return target_velocity

	var blended_dir := current_dir.slerp(target_dir, turn_sharpness * delta)
	return blended_dir * current_horizontal.length()


func _handle_jump() -> void:
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
