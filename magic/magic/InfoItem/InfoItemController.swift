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
    
    var infoItemPresenter: Presenter?
    
    var card: Card! {
        didSet {
            navigationItem.title = card.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*self.infoItemPresenter = Presenter()
        self.infoItemPresenter?.infoItemView = self
        self.infoItemPresenter.infoItemInteractor = Interactor()
       
        self.infoItemPresenter?.infoItem.Interactor?.infoItemPresenter = self.presenter
        */
        /*name.text = card.name
        descr.text = card.descr
        let url = card.imageUrl
        cardPhoto.kf.setImage(with: url)*/
         
    }
    
    func showCard(labelName:String,description:String,cardPhoto:UIImageView){
        self.name.text = labelName
        self.descr.text = description
        self.cardPhoto = cardPhoto
    }

}
