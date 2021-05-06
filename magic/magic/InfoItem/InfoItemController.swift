//
//  InfoItemController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 20/4/21.
//

import UIKit

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
    
    /*private func bindViewModel(){
        viewModel.objectWillChange.sink { [ weak self] in
            guard self != nil else {
                return
            }
        }
    }*/

}
