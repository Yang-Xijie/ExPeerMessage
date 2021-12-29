// VC+MultipeerConnectivity.swift

import Foundation
import MultipeerConnectivity
import UIKit

extension ViewController: MCSessionDelegate {
    func session(_: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DispatchQueue.main.async {
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

            if self.mcSession.connectedPeers.count == 0 {
                self.sendButton.isEnabled = false
            } else {
                self.sendButton.isEnabled = true
            }
        }
    }

    func session(_: MCSession, didReceive _: Data, fromPeer _: MCPeerID) {}

    func session(_: MCSession, didReceive _: InputStream, withName _: String, fromPeer _: MCPeerID) {}

    func session(_: MCSession, didStartReceivingResourceWithName _: String, fromPeer _: MCPeerID, with _: Progress) {}

    func session(_: MCSession, didFinishReceivingResourceWithName _: String, fromPeer _: MCPeerID, at _: URL?, withError _: Error?) {}
}

extension ViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ vc: MCBrowserViewController) {
        print("browserViewControllerDidFinish")
//        vc.dismiss(animated: true, completion: nil)
    }

    func browserViewControllerWasCancelled(_ vc: MCBrowserViewController) {
        print("browserViewControllerWasCancelled")
        vc.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: MCAdvertiserAssistantDelegate {}
