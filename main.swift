import Foundation

guard CommandLine.arguments.count == 3 else {
    print("Usage: \(CommandLine.arguments[0]) <PrimaryDeviceName> <FallbackDeviceName>")
    exit(1)
}

let primaryDevice = CommandLine.arguments[1]
let fallbackDevice = CommandLine.arguments[2]

setAudioInputDevice(primaryDevice: primaryDevice, fallbackDevice: fallbackDevice)

