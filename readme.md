## macos-mic-selector
On Mac OS, this allows you to set your audio input device from the command line.

Useful in the event of a bluetooth device that likes to become the active audio input device by default every time it connects to your Mac, like AirPods. This way you can automate overriding that behavior.

## Installation
`xtools` must first be installed from the AppStore. Then, from the command line:
```
git clone https://github.com/myersm0/macos-mic-selector
cd macos-mic-selector
swiftc AudioDeviceManager.swift main.swift -o set_mic
```

## Usage
You can specify a primary device that you want to use, and a fallback device in the event that mic is not available. For example, I always want to use my Samson Q9U if it's plugged in, or otherwise my laptop's builtin mic:
```
set_mic "Samson Q9U" "MacBook Pro Microphone"
```

Or if you only have one device that you want to use, without a fallback:
```
set_mic "MacBook Pro Microphone"
```

