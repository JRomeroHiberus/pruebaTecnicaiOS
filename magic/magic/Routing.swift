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
    var navigationController: UINavigationController?
    
    init() {
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.routing = self
        interactor.presenter = presenter
        navigationController = UINavigationController(rootViewController: viewController)
        
    }
}
