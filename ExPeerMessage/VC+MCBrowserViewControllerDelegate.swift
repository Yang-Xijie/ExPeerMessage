// VC+MCBrowserViewControllerDelegate.swift

import MultipeerConnectivity
import UIKit

extension ViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ vc: MCBrowserViewController) {
        print("browserViewControllerDidFinish()")
        vc.dismiss(animated: true, completion: nil)
    }

    func browserViewControllerWasCancelled(_ vc: MCBrowserViewController) {
        print("browserViewControllerWasCancelled()")
        vc.dismiss(animated: true, completion: nil)
    }
}
