extends Node

# This is the base class for which shall serve as the genesis to all Recoilnaut weaponry
# Results may vary

@export var damage := 10;
@export var fireRate := .2;
@export var bulletSpeed := 1000;
@export var reloadTime := 1.5;

signal fire();

var canFire := true;
