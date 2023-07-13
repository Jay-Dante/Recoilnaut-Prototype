extends Node2D

@onready var bullets = $Bullets;
@onready var player = $Recoilnaut;
@onready var asteroids = $Debris/Asteroids;

var asteroid_scene = preload("res://Scenes/asteroid.tscn");

func _ready():
	player.connect("pb_shot", _on_player_pb_shot);
	
	for Asteroid in asteroids.get_children():
		Asteroid.connect("destroyed", _on_asteroid_destroyed);

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene();

func _on_player_pb_shot(bullet):
	bullets.add_child(bullet);

# astroid is destroyed
func _on_asteroid_destroyed(pos, size):
	for i in range(2):
		match size:
			Asteroid.BodySize.LARGE:
				asteroid_drop(pos, Asteroid.BodySize.MEDIUM);
				print("Large Asteroid Destroyed");
			Asteroid.BodySize.MEDIUM:
				asteroid_drop(pos, Asteroid.BodySize.SMALL);
			Asteroid.BodySize.SMALL:
				pass

# determine what is spawned from destroying an asteroid: More asteroids or items
func asteroid_drop(pos, size):
	print("Asteroid_Drop Called")
	var a = asteroid_scene.instantiate();
	a.global_position = pos;
	a.size = size;
	a.connect("destroyed", _on_asteroid_destroyed);
	asteroids.add_child(a);
