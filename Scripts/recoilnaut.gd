extends CharacterBody2D

signal pb_shot(bullet);

@export var ACCELERATION := 10;
@export var MAX_SPEED := 350;
@export var ROTATION_SPEED := 100;
@export var RECOIL_FORCE := 250;

@onready var weapon = $Weapon;

var pistol_bullet = preload("res://Scenes/pistol_bullet.tscn");
var recoil_direction = Vector2.ZERO;

func _process(delta):
	
	# rotate to cursor
	var mouse_position := get_global_mouse_position();
	var direction := mouse_position - global_position;
	var screen_size = get_viewport_rect().size;
	rotation = direction.angle() - deg_to_rad(-90);
	
	#screen wrapping
	if global_position.y < 0:
		global_position.y = screen_size.y;
	elif global_position.y > screen_size.y:
		global_position.y = 0;
		
	if global_position.x < 0:
		global_position.x = screen_size.x;
	elif global_position.x > screen_size.x:
		global_position.x = 0;

	if Input.is_action_just_pressed("fire"):
		fire_bullet();
	
func _physics_process(delta):
	
	var input_vector := Vector2(0, Input.get_axis("forward", "backward"));
	
	velocity += input_vector.rotated(rotation) * ACCELERATION;
	#velocity = velocity.limit_length(MAX_SPEED)
	
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 3);
	
	move_and_slide();
	
# fire them bullets
func fire_bullet():
	var pb = pistol_bullet.instantiate();
	pb.global_position = weapon.global_position;
	pb.rotation = rotation;
	emit_signal("pb_shot",pb);
	apply_recoil_force();
	$Weapon/Gunshot.play();
	$Weapon/Bulletsmoke.emitting = true;
	$Weapon/Bulletsmoke.restart()
	
func apply_recoil_force():
	recoil_direction = (get_global_mouse_position() - global_position).normalized() * -1
	velocity += recoil_direction * RECOIL_FORCE;
