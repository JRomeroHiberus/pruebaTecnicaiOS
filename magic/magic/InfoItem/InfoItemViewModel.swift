//
//  InfoItemViewModel.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 11/5/21.
//

import Foundation
import Moya

class InfoItemViewModel {
    
    var cartaStore: CardStore = CardStore()
    let provider = MoyaProvider<MagicAPI>()
    let jsonDecoder = JSONDecoder()
    
    var currentPage = 1
    var isFetchInProgress = false
    var itemData = ItemData(cardStorage: [])
    
    func fetchCards() {
        
        return Observable.create { observer in
            self.provider.request(.pagination(page: self.currentPage)) { result in
            switch result {
            case .success(let response):
                do {
                    print("Fetch correcto")
                    self.isFetchInProgress = false
                    let magicResponse = try self.jsonDecoder.decode(MagicAPI.MagicResponse.self, from: response.data)
                    let cards = magicResponse.cards.filter { $0.imageUrl != nil }
                    observer.onNext(cards)
                    self.currentPage += 1
                 
                } catch {
                   
                    print(error)
                }
            case .failure(let error):
                print("Aqui")
                print(error)
            }
        }
            return Disposables.create {  }
    }
}
    
}
