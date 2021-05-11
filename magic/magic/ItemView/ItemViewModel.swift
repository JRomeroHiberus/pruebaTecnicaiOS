//
//  ItemViewModel.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 7/5/21.
//

import Foundation
import Moya
import Combine
import RxSwift
import RxCocoa

class ItemViewModel {

    var cartaStore: CardStore = CardStore()
    let provider = MoyaProvider<MagicAPI>()
    let jsonDecoder = JSONDecoder()
    var currentPage = 1
    var isFetchInProgress = false
    var itemData = ItemData(cardStorage: [])
    let itemChanged = PassthroughSubject<Void, Never>()
    
    /*func fetchCards() {
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
                            self.itemData.addItem(item: card)
                        }
                        // print("Fetch completado")
                        self.currentPage += 1
                        self.itemChanged.send()
                       
                } catch {
                    print(error)
                }
            case .failure(let error):
                    print(error)
            }
        }
    }*/
    
    func fetchCards() -> Observable<[Card]> {
       /* guard !isFetchInProgress else {
            return
        }*/
        
        isFetchInProgress = true
        return Observable.create { observer in
            self.provider.request(.pagination(page: self.currentPage)) { result in
            switch result {
            case .success(let response):
                do {
                    self.isFetchInProgress = false
                    let magicResponse = try self.jsonDecoder.decode(MagicAPI.MagicResponse.self, from: response.data)
                    let cards = magicResponse.cards.filter { $0.imageUrl != nil }
                    observer.onNext(cards)
                    self.currentPage += 1
                    self.itemChanged.send()
                 
                } catch {
                    print(error)
                }
            case .failure(let error):
                    print(error)
            }
                
        }
            return Disposables.create {  }
    }
}
    
    /*func openDetailViewController(infoItem: InfoItemController, row: Int) -> InfoItemController {
        infoItem.row = row
        infoItem.viewModel = self
        return infoItem
    }*/
}
