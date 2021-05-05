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
        viewController.presenter = presenter
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
    }
    
    func openItemViewController() {
        let addVC: ItemViewController = storyBoard.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        addVC.presenter = self.presenter
        viewController.present(addVC, animated: true, completion: nil)
        addVC.viewDidLoad()
        
    }
    
    func openItemDetailView() {
        let addVC: InfoItemController = storyBoard.instantiateViewController(withIdentifier: "InfoItemViewController") as! InfoItemController
        addVC.infoItemPresenter = self.infoItemPresenter
        viewController.present(addVC, animated: true, completion: nil)
    }
    
}
