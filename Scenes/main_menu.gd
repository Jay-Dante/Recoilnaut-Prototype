extends Control

@onready var UM = $StoryModeButton/UnnecessaryMonologue;
@onready var Controls = $ControlsButton/Instructions;
@onready var Credits = $CreditsButton/Credits;
#@onready var audioPlayer = $DaDrone;
#
#func _ready():
#	var audio = preload("res://Assets/Music/HeresyoDronedoo.wav");
#	audioPlayer.stream = audio;
#	audioPlayer.loop = true;
#	audioPlayer.play();
	
func _on_story_mode_button_pressed():
	UM.visible = !UM.visible;


func _on_endless_mode_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Test_Scene.tscn");


func _on_controls_button_pressed():
	Controls.visible = !Controls.visible;


func _on_credits_button_pressed():
	Credits.visible = !Credits.visible;


func _on_quit_button_pressed():
	get_tree().quit();
