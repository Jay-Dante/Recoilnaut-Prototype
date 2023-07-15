class_name Debris extends Area2D

const ROTATIONAL_FORCE = .5;

var move_vec := Vector2(0,-1);

enum BodySize{SMALL, MEDIUM, LARGE};
@export var size := BodySize.LARGE;

var speed = 0;

@onready var sprite = $Sprite2D;
@onready var cshape = $CollisionShape2D;

var smallSpriteTextures = [
	"res://Assets/Art/Debris/Small/Debris7.png",
	"res://Assets/Art/Debris/Small/Debris14.png"
	]

var mediumSpriteTextures = [
	"res://Assets/Art/Debris/Medium/Debris4.png",
	"res://Assets/Art/Debris/Medium/Debris6.png",
	"res://Assets/Art/Debris/Medium/Debris9.png",
	"res://Assets/Art/Debris/Small/Debris16.png",
	"res://Assets/Art/Debris/Small/Debris13.png",
	"res://Assets/Art/Debris/Small/Debris15.png",
	"res://Assets/Art/Debris/Medium/Debris10.png",
	"res://Assets/Art/Debris/Small/Debris17.png"
]

var largeSpriteTextures = [
	"res://Assets/Art/Debris/Large/Debris5.png",
	"res://Assets/Art/Debris/Large/Debris8.png",
	"res://Assets/Art/Debris/Large/Debris11.png",
	"res://Assets/Art/Debris/Large/Debris12.png"
]
	
			
func _ready():
	rotation = randf_range(0,2*PI);
	#rotation_degrees += randf_range(-2*PI, 2*PI);
	
	var randomValue = randi() % 3
	
	if randomValue == 0:
		size = BodySize.SMALL;
	elif randomValue == 1:
		size = BodySize.MEDIUM;
	else:
		size = BodySize.LARGE;
	
	# debris variability
	match size:
		BodySize.SMALL:
			#speed = randf_range(100,200);
			sprite.texture = load(smallSpriteTextures[randi() % smallSpriteTextures.size()]);
			cshape.shape = preload("res://Resources/asteroid_collision_small.tres");
			sprite.scale = Vector2(.3,.3);
		BodySize.MEDIUM:
			#speed = randf_range(100,150);
			sprite.texture = load(mediumSpriteTextures[randi() % mediumSpriteTextures.size()]);
			cshape.shape = preload("res://Resources/asteroid_collision_medium.tres");
			sprite.scale = Vector2(.8,.8);
		BodySize.LARGE:
			#speed = randf_range(50,100);
			sprite.texture = load(largeSpriteTextures[randi() % largeSpriteTextures.size()]);
			cshape.shape = preload("res://Resources/asteroid_collision_large.tres");
			sprite.scale = Vector2(1.2,1.2);
	# print(rotation_degrees);
	# print(speed);
	
func _physics_process(delta):
	
	global_position += move_vec.rotated(rotation) * speed * delta;
	# object rotation
	var rotationalForce = ROTATIONAL_FORCE * delta;

	rotation += rotationalForce;



func _on_body_entered(body):
	if body is Recoilnaut:
		var recoilnaut = body;
		recoilnaut.死ね();
		print("Debris Kill");
