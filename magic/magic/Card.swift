//
//  Item.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit

class Card: Equatable, Codable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var descr: String
    var imageUrl: URL?
   // let remoteURL: URL?
    // var image: UIImage
    
    init(name: String, descr: String, url: URL?) {
        self.name = name
        self.descr = descr
        imageUrl = url
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case descr = "type"
        case imageUrl
        // case image = "imageUrl"
    }
}
