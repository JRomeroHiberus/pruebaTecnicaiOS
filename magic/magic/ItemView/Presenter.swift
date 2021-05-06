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
    var routing: Routing?
    
    func fetchCards() {
        interactor?.fetchCards()
    }
    
    func receiveFetchResponse(cards: ItemData) {
        view?.setListWithItems(cards: cards)
    }
    
    func openItemDetailView(infoItemController: InfoItemController, row: Int, itemView: ItemViewController) -> InfoItemController {
   
        let infoItemAux = routing!.openItemDetailView(infoItemController: infoItemController, row: row, itemView: itemView)
        return infoItemAux
    }
  
}
