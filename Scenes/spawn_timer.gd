extends Timer

signal object_instantiated(obj: Node2D);

@onready var asteroid_obs = preload("res://Scenes/asteroid.tscn");
@onready var debris_obs = preload("res://Scenes/debris.gd");

var location = Vector2();

func instance_objects():
	var obj1 = null;
	emit_signal("object_instantiated", obj1);
	print("object signal emitted");

func _on_timeout():
	randomize();
	location.x = randi_range(1280, 1600);
	location.y = randi_range(800, 1000);
	
	instance_objects();
