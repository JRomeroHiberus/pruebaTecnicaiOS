//
//  InfoItemController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 20/4/21.
//

import UIKit

class InfoItemController: UIViewController {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var cardPhoto: UIImageView!
    @IBOutlet var descr: UILabel!
    
    
    
    
    var card: Card! {
        didSet{
            navigationItem.title = card.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        name.text = card.name
        descr.text = card.descr
        let url = card.imageUrl
        cardPhoto.kf.setImage(with: url)
         
    }
    
    
    

}
