extends Area2D

@export var speed := 1000

var move_vec := Vector2(0, -1)

func _physics_process(delta):
	global_position += move_vec.rotated(rotation) * speed * delta
	$Trail.emitting = true;

# kill the bullet once it hits off screen
# player can only kill what they see lol
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();
