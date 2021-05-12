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
        routing = Routing()
        if routing == nil {
            print("No inicializado")
        }
    }
  
    @IBAction func openItemViewController(_ sender: UIButton) {
        switch sender {
        case continueButton:
            routing?.openItemViewController(presentationView: self)
        default:
            return
        }
    }
    
}
