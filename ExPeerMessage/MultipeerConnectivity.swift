// MultipeerConnectivity.swift

import Foundation
import MultipeerConnectivity

// MARK: - MultipeerConnectivity Constants

/// `MCPeerID` of the current device
///
/// displayName is `UIDevice.current.name`
///
/// `macOS`: `System Preferences > Sharing > Computer Name`
///
/// `iOS/iPadOS`: `Settings > General > About > Name`
let myID = MCPeerID(displayName: UIDevice.current.name)

/// You should include two keys in your app's Info.plist file.
///
/// The keys are `Privacy - Local Network Usage Description (NSLocalNetworkUsageDescription)` and `Bonjour services (NSBonjourServices)`.
///
/// For the privacy key, include a human-readable description of what benefit the user gets by allowing your app to access devices on the local network.
///
/// The Bonjour services key is an array of service types that your app will browse for. For MultipeerKit, the entry should be in the format `_<appServiceType>._tcp`.
let appServiceType = "ExPeerMessage"
