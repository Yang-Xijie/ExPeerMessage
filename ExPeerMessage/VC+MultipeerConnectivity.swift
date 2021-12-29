// VC+MultipeerConnectivity.swift

import Foundation
import MultipeerConnectivity
import UIKit

extension ViewController: MCSessionDelegate, MCBrowserViewControllerDelegate {
    func session(_: MCSession, peer _: MCPeerID, didChange _: MCSessionState) {}

    func session(_: MCSession, didReceive _: Data, fromPeer _: MCPeerID) {}

    func session(_: MCSession, didReceive _: InputStream, withName _: String, fromPeer _: MCPeerID) {}

    func session(_: MCSession, didStartReceivingResourceWithName _: String, fromPeer _: MCPeerID, with _: Progress) {}

    func session(_: MCSession, didFinishReceivingResourceWithName _: String, fromPeer _: MCPeerID, at _: URL?, withError _: Error?) {}

    func browserViewControllerDidFinish(_: MCBrowserViewController) {}

    func browserViewControllerWasCancelled(_: MCBrowserViewController) {}
}
