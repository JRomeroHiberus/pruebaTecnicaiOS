//
//  Routing.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 28/4/21.
//

import Foundation
import UIKit

class Routing {
       
    let viewController: ItemViewController = ItemViewController()
    let presenter = Presenter()
    let interactor = Interactor()
    let model = Model()
    let presentationView: PresentationView = PresentationView()
    
    let infoItemController: InfoItemController = InfoItemController()
    let infoItemPresenter = InfoItemPresenter()
    let infoItemInteractor = InfoItemInteractor()
    
    var navigationController: UINavigationController?
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    init() {
        // viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.routing = self
        presenter.interactor?.model = self.model
        interactor.presenter = presenter
        
        presentationView.routing = self
        
        infoItemController.infoItemPresenter = InfoItemPresenter()
        infoItemPresenter.view = infoItemController
        infoItemPresenter.routing = self
        infoItemPresenter.interactor = InfoItemInteractor()
        infoItemPresenter.interactor?.presenter = infoItemController.infoItemPresenter
        infoItemPresenter.interactor?.model = self.model
        
        navigationController = UINavigationController(rootViewController: presentationView)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.leftItemsSupplementBackButton = true
    }
    
    func openItemViewController(presentationView: PresentationView) {
        let addVC: ItemViewController = storyBoard.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
       // addVC.presenter = self.presenter
        navigationController?.pushViewController(addVC, animated: true)
        
    }
    
    func openItemDetailView(infoItemController: InfoItemController, row: Int, itemView: ItemViewController) -> InfoItemController {
        
         infoItemController.infoItemPresenter = InfoItemPresenter()
         infoItemController.infoItemPresenter?.view = infoItemController
         infoItemController.infoItemPresenter?.interactor = InfoItemInteractor()
         infoItemController.infoItemPresenter?.interactor?.presenter = infoItemController.infoItemPresenter
         infoItemController.infoItemPresenter?.interactor?.model = itemView.model
         infoItemController.row = row
         return infoItemController
        
    }
    
}
