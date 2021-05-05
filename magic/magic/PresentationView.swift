//
//  ViewController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit

class PresentationView: UIViewController {

    var routing: Routing?
    
    @IBOutlet var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // continueButton.addTarget(self, action: #selector(openItemViewController), for: .allTouchEvents)
        routing = Routing()
    }
  
    @IBAction func openItemViewController(_ sender: UIButton) {
        switch sender {
        case continueButton:
            routing?.openItemViewController()
        default:
            return
        }
    }
    
}
