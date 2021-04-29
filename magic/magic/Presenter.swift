//
//  Presenter.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 28/4/21.
//

// Recibe el fetch del interactor en forma de string

import Foundation
class Presenter {
    var view: ItemViewController?
    var interactor: Interactor?
    var routing: Routing?
    
    init() {}

    func showCard() {
        
    }
    
    func fetchCards() {
        print("Presenter recibe peticion de fetch")
        interactor?.fetchCards()
    }
    
    func receiveFetchResponse(cardNames: [String]) {
        view!.setListWithItems(cardNames: cardNames)
    }
}
