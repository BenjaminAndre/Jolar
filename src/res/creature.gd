extends Resource
class_name Creature

@export var name : String
@export var type : Enums.Type
@export var sprite : Texture2D
@export var base_health : int
@export var moves : Array[Move]

# Sum of the three cannot be greater than 1
@export var base_toothy : float #Saw signal wave [0-1]
@export var base_wavy : float # Sine signal wave [0-1]
@export var base_blocky : float # Square signal wave [0-1]

var health : int
# Sum of the three cannot be greater than 1.5
var toothy : float
var wavy : float
var blocky : float

func _init():
    name = "Missingno"
    base_health = 1
    health = 1
    moves = []
    base_toothy = 0
    base_blocky = 0
    base_wavy = 0
    blocky = 0
    toothy = 0
    wavy = 0
