//
//  Routing.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 28/4/21.
//

import Foundation
import UIKit


class Routing {
    let vc:ItemViewController = ItemViewController()
    let presenter = Presenter()
    let interactor = Interactor()
    var navigationController: UINavigationController?
    
    init(){
        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        presenter.routing = self
        interactor.presenter = presenter
        navigationController = UINavigationController(rootViewController: vc)
        
    }
}
