//
//  InfoItemController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 20/4/21.
//

import UIKit

class InfoItemController: UIViewController {
    
    @IBOutlet var nombre: UILabel!
    @IBOutlet var fotoCarta: UIImageView!
    @IBOutlet var descr: UILabel!
    
    var carta: Carta!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nombre.text = carta.name
        descr.text = carta.descr
    }
    
    

}
