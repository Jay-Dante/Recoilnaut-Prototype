extends Area2D

var move_vec := Vector2(0,-1);

enum BodySize{SMALL, MEDIUM, LARGE};
@export var size := BodySize.LARGE;

var speed := 50;

@onready var sprite = $Sprite2D;

func _ready():
	rotation = randf_range(0,2*PI);
	
	# asteroid variability
	match size:
		BodySize.SMALL:
			speed = randf_range(100,200);
			
		BodySize.MEDIUM:
			speed = randf_range(100,150);
		BodySize.LARGE:
			speed = randf_range(50,100);
	# print(rotation_degrees);
	print(speed);
	
func _physics_process(delta):
	global_position += move_vec.rotated(rotation) * speed * delta;
