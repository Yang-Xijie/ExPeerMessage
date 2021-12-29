import MultipeerConnectivity
import UIKit

extension ViewController: MCSessionDelegate {
    /// Called when the state of a nearby peer changes.
    func session(_: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            print("notConnected: \(peerID.displayName)")
        case .connecting:
            print("connecting: \(peerID.displayName)")
        case .connected:
            print("connected: \(peerID.displayName)")
        @unknown default:
            fatalError()
        }
    }

    func session(_: MCSession, didReceive _: Data, fromPeer _: MCPeerID) {}

    func session(_: MCSession, didReceive _: InputStream, withName _: String, fromPeer _: MCPeerID) {}

    func session(_: MCSession, didStartReceivingResourceWithName _: String, fromPeer _: MCPeerID, with _: Progress) {}

    func session(_: MCSession, didFinishReceivingResourceWithName _: String, fromPeer _: MCPeerID, at _: URL?, withError _: Error?) {}
}
