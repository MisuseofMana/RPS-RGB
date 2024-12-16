extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var rock_origin = $Marker2D

@export var ROCK : PackedScene

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if Input.is_action_just_pressed("rock"):
		shoot()

func shoot():
	#var rock = Rock.new(rock_origin.position.x, rock_origin.position.y)
	
	var rock : Rock = ROCK.instantiate()
	rock.start_position = rock_origin.global_position
	rock.position = rock_origin.global_position
	get_tree().root.add_child(rock)
	
	#rock.transform = rock_origin.global_transform
