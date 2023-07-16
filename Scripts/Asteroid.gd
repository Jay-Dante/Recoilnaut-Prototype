class_name Asteroid extends Area2D

signal destroyed(pos, size, points);

#const ROTATIONAL_FORCE = .5;

var move_vec := Vector2(0,-1);

enum BodySize{SMALL, MEDIUM, LARGE};
@export var size := BodySize.LARGE;

var speed = 0;

@onready var sprite = $Roid;
@onready var cshape = $CollisionShape2D;

var spriteTextures = [
	"res://Assets/Art/Debris/Large/Debris1.png",
	"res://Assets/Art/Debris/Medium/Debris2.png",
	"res://Assets/Art/Debris/Small/Debris3.png",
	]
	
	
var points: int:
	get:
		match size:
			BodySize.SMALL:
				return 200;
			BodySize.MEDIUM:
				return 100;
			BodySize.LARGE:
				return 50;
			_:
				return 0;

func _ready():
	rotation = randf_range(0,2*PI);
	#rotation_degrees += randf_range(-2*PI, 2*PI);
	# asteroid variability
	match size:
		BodySize.SMALL:
			speed = randf_range(100,200);
			sprite.texture = load(spriteTextures[randi() % spriteTextures.size()]);
			#cshape.shape = preload("res://Resources/asteroid_collision_small.tres");
			cshape.set_deferred("shape",preload("res://Resources/asteroid_collision_small.tres"));
			sprite.scale = Vector2(.25,.25);
		BodySize.MEDIUM:
			speed = randf_range(100,150);
			sprite.texture = load(spriteTextures[randi() % spriteTextures.size()]);
			#cshape.shape = preload("res://Resources/asteroid_collision_medium.tres");
			cshape.set_deferred("shape",preload("res://Resources/asteroid_collision_medium.tres"));
			sprite.scale = Vector2(.5,.5);
		BodySize.LARGE:
			speed = randf_range(50,100);
			sprite.texture = load(spriteTextures[randi() % spriteTextures.size()]);
			#cshape.shape = preload("res://Resources/asteroid_collision_large.tres");
			cshape.set_deferred("shape",preload("res://Resources/asteroid_collision_large.tres"));
			sprite.scale = Vector2(1,1);
			
	await get_tree().create_timer(30).timeout;
	print("DELETED");
	queue_free();
	
func _physics_process(delta):
	global_position += move_vec.rotated(rotation) * speed * delta;
	

func destroy():
	emit_signal("destroyed", global_position, size, points);
	sprite.visible = false;
	#cshape.disabled = true;
	cshape.set_deferred("disabled", true);
	$Impact.play();
	$Impacticles.emitting = true;
	#$Impacticles.restart();
	await get_tree().create_timer(2).timeout;
	queue_free();

# 死ね
func _on_body_entered(body):
	if body is Recoilnaut:
		var recoilnaut = body;
		recoilnaut.死ね();
		print("Asteroid Kill");
