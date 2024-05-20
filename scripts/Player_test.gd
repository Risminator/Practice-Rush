extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var dash_timer: Timer = $DashTimer
@onready var ghost_timer: Timer = $GhostTimer
@onready var raycast: RayCast2D = $RightCast2D
const dash_ghost: PackedScene = preload("res://scenes/dash_ghost.tscn")


@export var jump_height: float = 125
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_descent: float = 0.35
@export var jump_buffer_time: int = 10
@export var coyote_time: int = 10

@onready var jump_velocity: float = (-2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity: float = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var fall_gravity: float = (2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)

@export var max_speed: float = 400.0
@export var accel: float = 750.0
@export var friction: float = 500.0
@export var dash_speed: float = 600.0

var jump_buffer_counter: int = 0
var coyote_counter: int = 0

var is_dashing: bool = false
var is_crouching: bool = false
var can_dash: bool = true

var left_ray_input: bool = false
var right_ray_input: bool = false

func get_gravity():
	if is_dashing:
		return 0
	else:
		return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	is_dashing = false
	velocity.y = jump_velocity


func _physics_process(delta):
	update_animation_parameters()
	if is_on_floor():
		coyote_counter = coyote_time
		can_dash = true
	else:
		velocity.y += get_gravity() * delta
		if coyote_counter > 0:
			coyote_counter -= 1
	if Input.is_action_just_pressed("move_up"):
		jump_buffer_counter = jump_buffer_time
	if jump_buffer_counter > 0:
		jump_buffer_counter -= 1
	if jump_buffer_counter > 0 and coyote_counter > 0:
		jump()
		jump_buffer_counter = 0
		coyote_counter = 0
	if Input.is_action_just_released("move_up") and velocity.y < 0.0:
		velocity.y *= 0.4
	
	is_crouching = is_on_floor() && Input.is_action_pressed("crouch") && !is_dashing
	var direction = Input.get_axis("move_left", "move_right") if !is_crouching else 0.0

	if direction and !is_dashing:
		sprite.scale.x = direction
		velocity.x += direction * accel * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
	elif !is_dashing:
		if absf(velocity.x) > friction * delta:
			velocity.x -= sign(velocity.x) * friction * delta
		else:
			velocity.x = 0
	else:
		is_crouching = false
		velocity.y = 0
		velocity.x = sign(sprite.scale.x) * dash_speed
	
	if Input.is_action_just_pressed("dash") and can_dash:
		start_dash()

	move_and_slide()
	
func start_dash():
	is_dashing = true
	can_dash = false
	instance_ghost()
	dash_timer.start()
	ghost_timer.start()

func instance_ghost():
	var ghost: Sprite2D = dash_ghost.instantiate()
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h
	ghost.scale.x = sprite.scale.x
	add_child(ghost)

func _on_dash_timer_timeout():
	is_dashing = false
	ghost_timer.stop()

func update_animation_parameters():
	animation_tree.set("parameters/conditions/is_crouching", is_crouching)
	animation_tree.set("parameters/conditions/is_idle", velocity == Vector2.ZERO && is_on_floor() && !is_dashing && !is_crouching)
	animation_tree.set("parameters/conditions/is_moving", velocity != Vector2.ZERO && is_on_floor() && !is_dashing && !is_crouching)
	animation_tree.set("parameters/conditions/is_in_air", !is_on_floor() && !is_dashing)
	animation_tree.set("parameters/conditions/is_dashing", is_dashing && !is_crouching)


func _on_ghost_timer_timeout():
	instance_ghost()
