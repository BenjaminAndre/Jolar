extends Node

@onready var name_label: RichTextLabel = $SubViewport/PanelContainer/Data/Name
@onready var pv_label: RichTextLabel = $SubViewport/PanelContainer/Data/PV
@onready var panel_container: PanelContainer = $SubViewport/PanelContainer
@export var creature : Creature

var is_players : bool

func _ready() -> void:
    name_label.text = creature.name

func _process(delta: float) -> void:
    pv_label.text = str(creature.health) + "/" + str(creature.temp_health)
    var override = StyleBoxFlat.new()
    override.set_border_width_all(5)
    if is_players :    
        override.border_color = Color.GREEN
    panel_container.add_theme_stylebox_override("panel", override)
    
