//
//  ItemStore.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit
import RxSwift

struct ItemData {
    var itemStorage = PublishSubject<[Card]>()
    
    /*init(cardStorage: [Card]) {
        itemStorage = cardStorage
    }
    
    func addItem(item: Card) {
        itemStorage.append(item)
    }*/
    
}
