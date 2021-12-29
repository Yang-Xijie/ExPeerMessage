# README

An playground app using `MultipeerConnectivity` to transfor data between iOS and macOS.

The goal is to share `ARKit` face tracking data on iOS with macOS, and share operation commands on macOS with iOS. Check apps such as `OBS Camera` `MotionTracker` `VTube Studio` for references.

`MultipeerConnectivity` use wireless connection mostly. Transfering data via USB is still a problem, which exists in `OBS Camera`.

used Swift package: https://github.com/insidegui/MultipeerKit

## Start from scratch

`Info.plist`: The keys are Privacy - Local Network Usage Description (NSLocalNetworkUsageDescription) and Bonjour services (NSBonjourServices) (`_servicename._tcp`).

