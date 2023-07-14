extends Node2D

@onready var bullets = $Bullets;
@onready var player = $Recoilnaut;
@onready var asteroids = $Debris/Asteroids;
@onready var hud = $UI/HUD;
@onready var game_over = $UI/GameOverScreen;
@onready var player_spawn = $PlayerSpawn;

var asteroid_scene = preload("res://Scenes/asteroid.tscn");

var score := 0:
	set(value):
		score = value;
		hud.score = score;

var health = 1;
############################ NOTIFICATION FUNCTIONS ######################
func _ready():
	
	game_over.visible = false;
	score = 0;
	health = 1;
	player.connect("pb_shot", _on_player_pb_shot);
	player.connect("died", _on_player_died);
	
	for Asteroid in asteroids.get_children():
		Asteroid.connect("destroyed", _on_asteroid_destroyed);

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene();

############################ PLAYER FUNCTIONS ############################
func _on_player_pb_shot(bullet):
	bullets.add_child(bullet);

func _on_player_died():
	health -= 1;
	print(health);
	print("Player died");
	if health <= 0:
		await get_tree().create_timer(1).timeout;
		game_over.visible = true;
		player.disableInput();
#	else:
#		await get_tree().create_timer(1).timeout;
#		player.respawn(player_spawn.global_position);


############################ DEBRIS FUNCTIONS ############################
# astroid is destroyed
# TODO: Randomize if an asteroid gets destroyed fully, separates, or drops item
func _on_asteroid_destroyed(pos, size, points):
	score += points;
	for i in range(2):
		match size:
			Asteroid.BodySize.LARGE:
				asteroid_drop(pos, Asteroid.BodySize.MEDIUM);
				print("Large Asteroid Destroyed +", points);
			Asteroid.BodySize.MEDIUM:
				asteroid_drop(pos, Asteroid.BodySize.SMALL);
				print("Medium Asteroid Destroyed +", points);
			Asteroid.BodySize.SMALL:
				print("Small Asteroid Destroyed +", points);

# determine what is spawned from destroying an asteroid: More asteroids or items
# TODO: Implement Ammo & Health Drops
func asteroid_drop(pos, size):
	print("Asteroid_Drop Called")
	var a = asteroid_scene.instantiate();
	a.global_position = pos;
	a.size = size;
	a.connect("destroyed", _on_asteroid_destroyed);
	asteroids.add_child(a);

