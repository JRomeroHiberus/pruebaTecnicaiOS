//
//  ItemStore.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit
class ItemData {
    var itemStorage = [Card]()
    
    init(cardStorage: [Card]) {
        itemStorage = cardStorage
    }
    
    func addItem(item: Card) {
        itemStorage.append(item)
    }
    
}
