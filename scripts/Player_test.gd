extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_tree: AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true

func _process(delta):
	update_animation_parameters()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		$Sprite2D.flip_h = velocity.x < 0
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	#var isLeft = velocity.x < 0
	#$Sprite2D.flip_h = isLeft
	
func update_animation_parameters():
	animation_tree.set("parameters/conditions/idle", velocity == Vector2.ZERO && is_on_floor())
	animation_tree.set("parameters/conditions/is_moving", velocity != Vector2.ZERO && is_on_floor())
	animation_tree.set("parameters/conditions/is_in_air", !is_on_floor())
		
