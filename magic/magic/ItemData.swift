//
//  ItemStore.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit
class ItemData{
    var almacenItems = [Item]()
    
    func crearItem(){
        let nuevoItem = Item (name: "equis")
        
        almacenItems.append(nuevoItem)
    }
    
    
}
