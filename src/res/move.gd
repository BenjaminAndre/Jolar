extends Resource
class_name Move

# General
@export var name : String
@export var type : Enums.Type
@export var alteration_effect : float
@export var erosion_bonus : float
@export var collect_effect : float

# Self inflicted
@export var this_toothy_effect : float
@export var this_wavy_effect : float
@export var this_blocky_effect : float
@export var this_health_effect : int

# Inflicted to other
@export var other_toothy_effect : float
@export var other_wavy_effect : float
@export var other_blocky_effect : float
@export var other_health_effect : int

func _init():
    name = "Kachow"
    type = Enums.Type.PLANT
    alteration_effect = 0
    erosion_bonus = 0
    collect_effect = 0
    this_toothy_effect = 0
    this_wavy_effect = 0
    this_blocky_effect = 0
    this_health_effect = 0
    other_toothy_effect = 0
    other_wavy_effect = 0
    other_blocky_effect = 0
    other_health_effect = 0
