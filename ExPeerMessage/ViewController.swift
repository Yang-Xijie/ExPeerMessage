// ViewController.swift

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        print("ViewController.viewDidLoad()")

        // MARK: create

        let width = 200.0
        let height = 300.0
        let x = UIScreen.main.bounds.size.width / 2 - width / 2
        let y = UIScreen.main.bounds.size.height / 2 - height / 2
        let textView = UITextView(frame:
            .init(x: x,
                  y: y,
                  width: width,
                  height: height))
        textView.text = "haha\nhaha\nhaha\nhaha\nhaha\nhaha\nhaha\nhaha\nhaha\nhaha\nhaha\nhaha\nhaha\nhaha\nhaha\n"
        textView.textColor = .orange
        textView.textAlignment = .center

        textView.isEditable = false
        textView.isSelectable = false

        view.addSubview(textView)
    }
}
