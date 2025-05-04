extends Node

@onready var name_label: RichTextLabel = $SubViewport/PanelContainer/Data/Name
@onready var pv_label: RichTextLabel = $SubViewport/PanelContainer/Data/PV

@export var creature : Creature

func _ready() -> void:
    name_label.text = creature.name

func _process(delta: float) -> void:
    pv_label.text = str(creature.health) + "/" + str(creature.base_health)
    
