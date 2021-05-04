//
//  InfoItemPresenter.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 3/5/21.
//

import Foundation
import Kingfisher
import UIKit

class InfoItemPresenter {
    var view: InfoItemController?
    var interactor: InfoItemInteractor?
    
    func showCardRequest(row: Int) {
        interactor?.showCardRequest(row: row)
    }
    
    func sendResponseToView(card: Card) {
        view?.showCard(labelName: card.name, description: card.descr, photoURL: card.imageUrl!)
    }

}
