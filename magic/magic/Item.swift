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
    var descr : String
    var image: UIImage
    
    init(name:String, descr:String){
        self.name = name
        self.descr = descr
    }
    
    enum CodingKeys: String,CodingKey{
        case name
        case descr = "originalText"
        case image = "imageUrl"
    }
}
