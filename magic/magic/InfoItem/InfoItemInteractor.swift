//
//  InfoItemInteractor.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 3/5/21.
//

import Foundation

class InfoItemInteractor {
    var presenter: InfoItemPresenter?
    let jsonDecoder = JSONDecoder()
    var model = Model()
    func showCardRequest(row: Int) {
        let card = model.itemData.itemStorage[row]
        presenter?.sendResponseToView(card: card)
    }
}
