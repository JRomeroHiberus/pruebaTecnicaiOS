//
//  Presenter.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 28/4/21.
//

// Recibe el fetch del interactor en forma de string

import Foundation
import Kingfisher
class Presenter {
    var view: ItemViewController?
    var interactor: Interactor? 
    
    func fetchCards() {
        print("Presenter recibe peticion de fetch")
        interactor?.fetchCards()
    }
    
    func receiveFetchResponse(cards: ItemData) {
        view?.setListWithItems(cards: cards)
    }
}
