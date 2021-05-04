//
//  InfoItemInteractor.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 3/5/21.
//

import Foundation

class InfoItemInteractor: LoadAndSave {
    var presenter: InfoItemPresenter?
    var itemData: ItemData = ItemData(cardStorage: [])
    let jsonDecoder = JSONDecoder()
    
    func showCardRequest(row: Int) {
        do {
            print("Aqui estoy")
            let data = try InfoItemInteractor.loadJSON(file: "model")
            let magicResponse = try self.jsonDecoder.decode(MagicAPI.MagicResponse.self, from: data!)
            let cards = magicResponse.cards.filter { $0.imageUrl != nil }
            print(cards.count)
            print(row)
            let card = cards[row]
            print("Nombre de carta: \(card.name)")
            presenter?.sendResponseToView(card: card)
        } catch {
            print(error)
        }
    }
}
