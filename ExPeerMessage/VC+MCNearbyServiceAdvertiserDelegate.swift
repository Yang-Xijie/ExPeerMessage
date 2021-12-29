// VC+MCNearbyServiceAdvertiserDelegate.swift

import MultipeerConnectivity
import UIKit

extension ViewController: MCNearbyServiceAdvertiserDelegate {
    /// Called when an invitation to join a session is received from a nearby peer.
    func advertiser(_: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext _: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("didReceiveInvitationFromPeer + \(peerID.displayName)")
        invitationHandler(true, mcSession) // just accept the invitation
    }
}
