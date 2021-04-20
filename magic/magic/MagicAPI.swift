//
//  MagicAPI.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import Foundation
import UIKit


struct MagicAPI{
    private static let URLcartas = "https://api.magicthegathering.io/v1/cards"
    
    static var fullURL: URL{
        return  MagicURL()
    }
    
    
    private static func MagicURL() -> URL{
        var componentes = URLComponents(string: URLcartas)!
        let queryItems = [URLQueryItem]()
        componentes.queryItems = queryItems
        
        //return URL(string: URLcartas)!
        return componentes.url!
    }
    
    
    struct MagicResponse: Codable{
        let cards: [Carta]
        
    }
    
    
/*    struct MagicCardImage: Codable{
        let imageUrl:UIImage
    }*/
    
    
    static func cards(fromJSON data : Data) -> Result<[Carta] , Error> {
        do{
            let decoder = JSONDecoder()
            let magicResponse = try decoder.decode(MagicResponse.self, from:data)
            return .success(magicResponse.cards)
        } catch{
            return .failure(error)
        }
    }
}
