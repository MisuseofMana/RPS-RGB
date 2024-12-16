extends Area2D
class_name Rock

var speed = 750

var duration = 2.0
var time_elapsed = 0.0

var start_position : Vector2 = Vector2(0, 0)

var P0 = Vector2(0,0)  # Start point
var P1 = Vector2(300, -350)   # Control point
var P2 = Vector2(340, 1000)  # End point

func _ready():
	P0 = P0 + start_position
	position = P0
	P1 = P1 + start_position
	P2 = P2 + start_position
	print(P0)
	print(P1)
	print(P2)

func _physics_process(delta):
	time_elapsed += delta
	var t = time_elapsed / duration
	t = clamp(t, 0.0, 1.0)  # Ensure t stays within the range [0, 1]
	position = bezier(P0, P1, P2, t)

	# If the projectile has reached the end, you can stop moving or destroy it
	if t == 1.0:
		queue_free()
		
func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
	
func bezier(Position1: Vector2, Position2: Vector2, Position3: Vector2, t: float) -> Vector2:
	var x = (1 - t) * (1 - t) * P0.x + 2 * (1 - t) * t * P1.x + t * t * P2.x
	var y = (1 - t) * (1 - t) * P0.y + 2 * (1 - t) * t * P1.y + t * t * P2.y
	return Vector2(x, y)
