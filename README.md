## Introduction
This repository contains tools that can be useful for Godot developers:
You can add the classes manually to Autoload, or activating the plugin in the plugins tab

**Logger**: a simple logger class that allows you to log messages from your game or application.
**DiContainer**: a dependency injection container that makes it easy to manage dependencies between objects.
**SignalBus*: a signal bus class that allows you to send signals between objects without having to manually wire them up.
## Using the Logger
The Logger class is a simple way to log messages from your game or application. You can use it to debug issues, track events, or just provide information to the user. To use the logger,you need configure the logger to output logs to different places, such as the console, a file, or even a custom implementation. Extending BaseSink.

```gdscript
Logger.add_sink(Console.new())
```

 and then call one of the logging methods such as log, info, warning, or error. For example:

```gdscript
Logger.info("Starting game");
```

## Using the DiContainer
The DiContainer class is a dependency injection container that makes it easy to manage dependencies between objects. It allows you to decouple objects from their dependencies, making it easier to test and maintain your code.

To use the DiContainer, register the dependencies that your objects need. For example:

```
# create a di_init.gd script

DiContainer.register_singleton("Player", Player.new())
```

Then, when you want to create an object that needs a dependency, you can ask the container for an instance of the dependency instead of creating it yourself. For example:

```
# if a registered dependency needs to inject another dependecies, add a _inject func in the script and they will be injected as well

func _inject():
	player = DiContainer.resolveSingleton("PLAYER")
```
The get method will return an instance of MyObject with a reference to the 

If the dependency needs to call `_init`, and `_process methods`, just add `_initialize` and `tick` methods, and the DiContainer will handle

## Using the SignalBus
The SignalBus class is a signal bus that allows you to send signals between objects without having to manually wire them up. It's a great way to decouple objects from each other and make your code more modular.

```
SignalBus.subscribe("PLAYER", _do_something)
SignalBus.publish("PLAYER")
SignalBus.unsubscribe("PLAYER", _do_something)
```

You can also disconnect objects using the disconnect method.

## Contributing
Pull requests are welcome! If you have any bug fixes, feature requests, or improvements, feel free to contribute to this project.

## License
This project is licensed under the MIT license. See the LICENSE file for details.