import Foundation

let arguments = CommandLine.arguments

if arguments.count < 2 || arguments.count > 3 {
    print("Usage: ./setAudioDevice <primary_device_name> [<fallback_device_name>]")
    exit(1)
}

let primaryDevice = arguments[1]
let fallbackDevice = arguments.count == 3 ? arguments[2] : primaryDevice

setAudioInputDevice(primaryDevice: primaryDevice, fallbackDevice: fallbackDevice)

