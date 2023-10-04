@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("DiContainer", "tools/di_container.gd")
	add_autoload_singleton("SignalBus", "tools/signal_bus.gd")
	add_autoload_singleton("Logger", "tools/logger.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("DiContainer")
	remove_autoload_singleton("SignalBus")
	remove_autoload_singleton("Logger")
