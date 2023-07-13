extends Node2D

@onready var bullets = $Bullets
@onready var player = $Recoilnaut

func _ready():
	player.connect("pb_shot", _on_player_pb_shot)

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene();

func _on_player_pb_shot(bullet):
	bullets.add_child(bullet);
