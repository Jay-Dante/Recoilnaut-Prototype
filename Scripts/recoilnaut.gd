class_name Recoilnaut extends CharacterBody2D

signal pb_shot(bullet);
signal died;

@export var ACCELERATION := 10;
@export var MAX_SPEED := 350;
@export var ROTATION_SPEED := 100;
# TODO: Modify this so that it takes the recoil stats of the gun being used
@export var RECOIL_FORCE := 250;

@onready var weapon = $Weapon;
@onready var sprite = $PlayerSprite;
@onready var cshape = $CollisionShape2D;

var pistol_bullet = preload("res://Scenes/pistol_bullet.tscn");
var recoil_direction = Vector2.ZERO;
var knockback_direction = Vector2.ZERO;
var inputEnabled = true;
# it's alive!
var alive := true;

func _process(delta):
	
	# rotate to cursor
	if inputEnabled == true:
		var mouse_position := get_global_mouse_position();
		var direction := mouse_position - global_position;
		rotation = direction.angle() - deg_to_rad(-90);
	
func _physics_process(delta):
	
	var input_vector := Vector2(0, 0);
	var screen_size = get_viewport_rect().size;
	
	velocity += input_vector.rotated(rotation) * ACCELERATION;
	# velocity = velocity.limit_length(MAX_SPEED)
	
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 3);
	
	move_and_slide();
	
##	screen wrapping
#	if global_position.y < 0:
#		global_position.y = screen_size.y;
#	elif global_position.y > screen_size.y:
#		global_position.y = 0;
#
#	if global_position.x < 0:
#		global_position.x = screen_size.x;
#	elif global_position.x > screen_size.x:
#		global_position.x = 0;

	if Input.is_action_just_pressed("fire") && inputEnabled == true:
		fire_bullet();

# fire them bullets
func fire_bullet():
	var pb = pistol_bullet.instantiate();
	pb.global_position = weapon.global_position;
	pb.rotation = rotation;
	emit_signal("pb_shot",pb);
	apply_recoil_force();
	$Weapon/Gunshot.play();
	$Weapon/Bulletsmoke.emitting = true;
	$Weapon/Bulletsmoke.restart();
	
func apply_recoil_force():
	recoil_direction = (get_global_mouse_position() - global_position).normalized() * -1
	velocity += recoil_direction * RECOIL_FORCE;

#func apply_knockback_force(area):
#	knockback_direction = (area - global_position).normalized() * -1
#	velocity += knockback_direction * RECOIL_FORCE;

# pronounced 死ね
func 死ね():
	if alive == true:
		alive = false;
		emit_signal("died");
		disableInput();
		sprite.visible = false;
		#cshape.disabled = true;
		cshape.set_deferred("disabled", true);
		$Status/DeathCrunch.play();
		$Status/Deathicles.emitting = true;

# revival
func respawn(pos):
	if alive == false:
		alive = true;
		global_position = pos;
		velocity = Vector2.ZERO;

func disableInput():
	inputEnabled = false;

func enableInput():
	inputEnabled = true;
