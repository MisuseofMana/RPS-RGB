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
	
func bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float) -> Vector2:
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	return q0.lerp(q1, t)
