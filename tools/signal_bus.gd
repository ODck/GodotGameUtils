extends Node
## author: ODck
## license: MIT
## description: 
##   It allows you to subscribe to signals, unsubscribe from signals, and publish signals.

## Subscribes to a signal. If the signal already exists, it will be connected immediately.
## Otherwise, it will create a new user-defined signal and connect it.
func subscribe(signal_name: String, callable: Callable) -> void:
	if get_signal_list().has(signal_name):
		connect(signal_name, callable)
	else:
		add_user_signal(signal_name, callable.get_bound_arguments())
		connect(signal_name, callable)

## Unsubscribes from a signal.
func unsubscribe(signal_name: String, callable: Callable):
	if  is_connected(signal_name, callable):
		disconnect(signal_name, callable)
	else:
		Logger.error("Signal %s unsubscribe failed, subscribe the signal first" % signal_name)

## Publishes a signal with an optional array of arguments.
func publish(signal_name: String, args: Array = []):
	if has_user_signal(signal_name):
		emit_signal(signal_name, args)
	else:
		Logger.warning("Signal %s published without subscribers" % signal_name)
