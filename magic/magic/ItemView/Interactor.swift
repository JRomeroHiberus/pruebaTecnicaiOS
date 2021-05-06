//
//  Interactor.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 28/4/21.
//

// Hace el fetch y pasa la respuesta al presenter

import Foundation
import Moya
class Interactor {
    
    var presenter: Presenter?
    let provider = MoyaProvider<MagicAPI>()
    let jsonDecoder = JSONDecoder()
    var model = Model()
    var isFetchInProgress = false
    var currentPage = 1
    
    struct Card {
        var name = ""
        var originalText = ""
        
        init(name: String, descr: String) {
            self.name = name
            self.originalText = descr
        }
    }
    
    func fetchCards() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        provider.request(.pagination(page: currentPage)) { result in
            switch result {
            case .success(let response):
                do {
                    self.isFetchInProgress = false
                    let magicResponse = try self.jsonDecoder.decode(MagicAPI.MagicResponse.self, from: response.data)
                    let cards = magicResponse.cards.filter { $0.imageUrl != nil }
                        for card in cards {
                            self.model.itemData.addItem(item: card)
                        }
                        self.currentPage += 1
                        self.sendResponseToPresenter()
                } catch {
                    print(error)
                }
            case .failure(let error):
                    print(error)
            }
        }
    }
    
    func sendResponseToPresenter() {
        presenter?.receiveFetchResponse(cards: model.itemData)
    }
    
}
