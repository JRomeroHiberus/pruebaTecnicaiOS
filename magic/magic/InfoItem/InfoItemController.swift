//
//  InfoItemController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 20/4/21.
//

import UIKit

struct InfoItemViewModel {
    private let model: Card
    
    init(model: Card) {
        self.model = model
    }
}

extension InfoItemViewModel {
    var name: String { return  "\(model.name)"}
    var descr: String { return "\(model.descr)"}
    var imageURL: URL { return model.imageUrl!}
    var row: Int { return 0}
    var infoItemPresenter: InfoItemPresenter { return InfoItemPresenter() }
    var dataModel: Model { return Model() }
}

class InfoItemController: UIViewController {
    
    // private let viewModel: InfoItemViewModel
    
    @IBOutlet var name: UILabel!
    @IBOutlet var cardPhoto: UIImageView!
    @IBOutlet var descr: UILabel!
    
    /*init(viewModel: InfoItemViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
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
        self.infoItemPresenter?.showCardRequest(row: row)
    }
    
    func showCard(labelName: String, description: String, photoURL: URL) {
        self.name.text = labelName
        self.descr.text = description
        cardPhoto.kf.setImage(with: photoURL)
    }

}
