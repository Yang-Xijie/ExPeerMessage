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

        DispatchQueue.main.async {
            if self.mcSession.connectedPeers.count != 0 {
                self.sendButton.isEnabled = true
            } else {
                self.sendButton.isEnabled = false
            }
        }
    }

    func session(_: MCSession, didReceive data: Data, fromPeer peer: MCPeerID) {
        DispatchQueue.main.async {
            let message = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
            self.chatView.text = self.chatView.text + "\n" + peer.displayName + ": " + message
        }
    }

    func session(_: MCSession, didReceive stream: InputStream, withName _: String, fromPeer _: MCPeerID) {
        stream.delegate = self
        stream.schedule(in: .main, forMode: RunLoop.Mode.default)
        stream.open()
        print("open an inputStream")
    }

    func session(_: MCSession, didStartReceivingResourceWithName _: String, fromPeer _: MCPeerID, with _: Progress) {}

    func session(_: MCSession, didFinishReceivingResourceWithName _: String, fromPeer _: MCPeerID, at _: URL?, withError _: Error?) {}
}
