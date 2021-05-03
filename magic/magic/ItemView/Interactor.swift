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
    var itemData: ItemData = ItemData(cardStorage: [])
    
    struct Card {
        var name = ""
        var originalText = ""
        
        init(name: String, descr: String) {
            self.name = name
            self.originalText = descr
        }
    }
    
    func fetchCards() {
       /* guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true*/
        print("Interactor recibe peticion de fetch")
        
        provider.request(.noPagination) { result in
            
            switch result {
            case .success(let response):
                do {
                    /*self.currentPage += 1
                    self.isFetchInProgress = false*/
                   // let data = saveJSON(jsonObject: response,filename:"model")
                    let magicResponse = try self.jsonDecoder.decode(MagicAPI.MagicResponse.self, from: response.data)
                    let cards = magicResponse.cards.filter { $0.imageUrl != nil }
                    for card in cards {
                        self.itemData.addItem(item: card)
                    }
                    print("Fetch realizado")
                    self.sendResponseToPresenter()
                    
                    // self.refresh()
                } catch {
                    print(error)
                }
            case .failure(let error):
                    // self.isFetchInProgress = false
                    print(error)
            }
            
        }
        
    }
    
    func sendResponseToPresenter() {
    
        presenter?.receiveFetchResponse(cards: itemData)
    }
    
}
