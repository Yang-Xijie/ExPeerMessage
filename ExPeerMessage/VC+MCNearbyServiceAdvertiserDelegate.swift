// VC+MCNearbyServiceAdvertiserDelegate.swift

import MultipeerConnectivity
import UIKit

extension ViewController: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext _: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("didReceiveInvitationFromPeer + \(peerID.displayName)")
        invitationHandler(true, mcSession)
    }
}
