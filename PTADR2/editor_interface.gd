extends VBoxContainer

@onready var spin_box_example: SpinBox = $bg/VBoxContainer/SpinboxHboxContainer/SpinBox
@onready var insert: Button = $bg/VBoxContainer/insert
@onready var cancel: Button = $bg/VBoxContainer/cancel

signal insert_pressed
signal cancel_pressed

func _ready() -> void:
	insert.pressed.connect(_on_insert_button_down)
	cancel.pressed.connect(_on_cancel_button_down)

# Danganmake will call this function when you click insert or save
func get_data() -> Dictionary:
	var data = {
		"example": spin_box_example.value,
	}
	return data

# Danganmake will call this function when you click edit in the timeline
func set_data(saved_data: Dictionary) -> void:
	if saved_data.has("example"):
		spin_box_example.value = saved_data["example"]
	
func _on_insert_button_down():
	insert_pressed.emit()
func _on_cancel_button_down():
	cancel_pressed.emit()
