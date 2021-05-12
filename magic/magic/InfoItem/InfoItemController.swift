//
//  InfoItemController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 20/4/21.
//

import UIKit
import Combine

class InfoItemController: UIViewController {
    
    var viewModel: ItemViewModel = ItemViewModel()
    
    @IBOutlet var name: UILabel!
    @IBOutlet var cardPhoto: UIImageView!
    @IBOutlet var descr: UILabel!
    
    var row: Int = 0
    
    var infoItemPresenter: InfoItemPresenter?
    var model = Model()
    
    var card: Card! {
        didSet {
            navigationItem.title = card.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cardAux = viewModel.itemData.itemStorage[row]
        showCard(labelName: cardAux.name, description: cardAux.descr, photoURL: cardAux.imageUrl!)
    }
    
    func showCard(labelName: String, description: String, photoURL: URL) {
        self.name.text = labelName
        self.descr.text = description
        cardPhoto.kf.setImage(with: photoURL)
    }

}
