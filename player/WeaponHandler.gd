extends Node3D

@export var Weapon1: Node3D
@export var Weapon2: Node3D

func _ready() -> void:
    equip(Weapon1)

func equip(active_weapon: Node3D) -> void:
    for child in get_children():
        if child == active_weapon:
            child.visible = true
            child.set_process(true)
            child.ammo_handler.update_ammo_label(child.ammo_type)
        else:
            child.visible = false
            child.set_process(false)
func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("weapon_1"):
        equip(Weapon1)
    if event.is_action_pressed("weapon_2"):
        equip(Weapon2)
    if event.is_action_pressed("next_weapon"):
        cycle_weapon(1)
    if event.is_action_pressed("last_weapon"):
        cycle_weapon(-1)

func cycle_weapon(i: int) -> void:
    var index = get_current_index()
    index = wrapi(index + i, 0, get_child_count() )
    equip(get_child(index))
    
func get_current_index() -> int:
    for index in get_child_count():
        if get_child(index).visible:
            return index
    return 0
        
        
