extends Area2D

@export var speed := 1000
@onready var cshape = $CollisionShape2D;
@onready var sprite = $Sprite2D;

var move_vec := Vector2(0, -1)

func _physics_process(delta):
	global_position += move_vec.rotated(rotation) * speed * delta
	$Trail.emitting = true;

# kill the bullet once it hits off screen
# player can only kill what they see lol
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();

# detect collision
func _on_area_entered(area):
	if area is Asteroid:
			var asteroid = area;
			asteroid.destroy();
			queue_free();
	
	if area is Debris:
			var debris = area;
			$Bullet_Rico.play();
			cshape.set_deferred("disabled", true);
			sprite.set_deferred("visible", false);
			await get_tree().create_timer(1).timeout;
			queue_free();
