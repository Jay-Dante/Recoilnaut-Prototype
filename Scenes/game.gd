extends Node2D

@onready var pistol_bullets = $Bullets;
@onready var recoilnaut = $Recoilnaut;

func _ready():
	recoilnaut.connect("pb_shot", _on_player_bullet_shot)

func _on_player_bullet_shot(pistol_bullet):
	pistol_bullets.add_child(pistol_bullet)
