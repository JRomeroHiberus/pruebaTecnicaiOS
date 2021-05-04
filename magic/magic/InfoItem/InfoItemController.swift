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
    
    var row: Int = 0
    
    var infoItemPresenter: InfoItemPresenter?
    
    var card: Card! {
        didSet {
            navigationItem.title = card.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.infoItemPresenter = InfoItemPresenter()
        self.infoItemPresenter?.view = self
        self.infoItemPresenter?.interactor = InfoItemInteractor()
       
        self.infoItemPresenter?.interactor?.presenter = self.infoItemPresenter
        
        self.infoItemPresenter?.showCardRequest(row: row)
        /*name.text = card.name
        descr.text = card.descr
        let url = card.imageUrl
        cardPhoto.kf.setImage(with: url)*/
         
    }
    
    func showCard(labelName: String, description: String, photoURL: URL) {
        self.name.text = labelName
        self.descr.text = description
        cardPhoto.kf.setImage(with: photoURL)
    }

}
