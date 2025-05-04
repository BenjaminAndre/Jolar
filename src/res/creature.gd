extends Resource
class_name Creature

@export var name : String
@export var type : Enums.Type
@export var moves : Array[Move]

# Sum of the three cannot be greater than 1

@export var base_health : int
@export var base_attack : int
@export var base_defense : int
@export var base_speed : int

var temp_health : int

var health : int
var attack : float
var defense : float
var speed : float

func _init():
    name = "Missingno"
    base_health = 1
    health = 1
    moves = []
    temp_health = 1
    base_attack = 0
    base_defense = 0
    base_speed = 0
    attack = 0
    defense = 0
    speed = 0
