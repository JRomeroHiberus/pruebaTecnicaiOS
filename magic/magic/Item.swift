//
//  Item.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit

class Item: Equatable, Codable{
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    
    init(name:String){
        self.name = name
    }
}
