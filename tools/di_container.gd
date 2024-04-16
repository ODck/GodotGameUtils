extends Node
## author: ODck
## license: MIT
## description: 
## 	This script manages the creation and retrieval of singletons in the application.

## A dictionary to store all registered singletons.
var _singleton : Dictionary = {
	
}

## Register a singleton object with the given name.
func register_singleton(name, object : Object) -> void:
	_singleton[name] = object

## Register a singleton object with the given name.
func register_singleton_node(name, object : Object) -> void:
	if(object.is_class("Node")):
		add_child(object)
	_singleton[name] = object

## Retrieve a singleton object by its name. If it doesn't exist, assert an error.
func resolveSingleton(name) -> Object:
	if _singleton.has(name):
		return _singleton[name]
	else:
		assert(false, "Instance {0} not registered".format([name]))
		return null

## Initialize all registered singletons.
func initialize():
	for instance in _singleton.values():
		if instance.has_method("_inject"):
			instance._inject()
		if instance.has_method("_initialize"):
			instance._initialize()

## Initialize all registered singletons.
func _process(delta):
	for instance in _singleton.values():
		if instance.has_method("_tick"):
			instance.tick(delta)
