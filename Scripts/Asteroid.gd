class_name Asteroid extends Area2D

signal destroyed(pos, size, points);

var move_vec := Vector2(0,-1);

enum BodySize{SMALL, MEDIUM, LARGE};
@export var size := BodySize.LARGE;

var speed = 0;

@onready var sprite = $Sprite2D;
@onready var cshape = $CollisionShape2D;

var points: int:
	get:
		match size:
			BodySize.SMALL:
				return 100;
			BodySize.MEDIUM:
				return 50;
			BodySize.LARGE:
				return 25;
			_:
				return 0;

func _ready():
	rotation = randf_range(0,2*PI);
	#rotation_degrees += randf_range(-2*PI, 2*PI);
	
	# asteroid variability
	match size:
		BodySize.SMALL:
			speed = randf_range(100,200);
			sprite.texture = preload("res://Assets/Art/Debris/Small/Debris3.png");
			cshape.shape = preload("res://Resources/asteroid_collision_small.tres")
			sprite.scale = Vector2(.25,.25);
		BodySize.MEDIUM:
			speed = randf_range(100,150);
			sprite.texture = preload("res://Assets/Art/Debris/Medium/Debris2.png");
			cshape.shape = preload("res://Resources/asteroid_collision_medium.tres")
			sprite.scale = Vector2(.5,.5);
		BodySize.LARGE:
			speed = randf_range(50,100);
			sprite.texture = preload("res://Assets/Art/Debris/Large/Debris1.png");
			cshape.shape = preload("res://Resources/asteroid_collision_large.tres")
	# print(rotation_degrees);
	# print(speed);
	
func _physics_process(delta):
	global_position += move_vec.rotated(rotation) * speed * delta;

func destroy():
	emit_signal("destroyed", global_position, size, points);
	print("Destroy Signal Emitted");
	queue_free();

# 死ね
func _on_body_entered(body):
	if body is Recoilnaut:
		var recoilnaut = body;
		recoilnaut.死ね();
