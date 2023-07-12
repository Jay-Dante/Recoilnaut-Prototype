extends Node2D

@onready var bullets = $Bullets
@onready var player = $Recoilnaut

func _ready():
	player.connect("pb_shot", _on_player_pb_shot)

func _on_player_pb_shot(bullet):
	bullets.add_child(bullet);
