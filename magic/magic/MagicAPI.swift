//
//  MagicAPI.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import Foundation
import UIKit
import Moya


//struct MagicAPI : TargetType{
enum MagicAPI : TargetType{
    case cards
    
   /* private static let URLcartas = "https://api.magicthegathering.io/v1/cards"
    var provider = MoyaProvider<<#Target: TargetType#>>(plugins: [NetworkLoggerPlugin()])
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
    
  */
    static func cards(fromJSON data : Data) -> Result<[Card] , Error> {
        do{
            let decoder = JSONDecoder()
            let magicResponse = try decoder.decode(MagicResponse.self, from:data)
            let cards = magicResponse.cards.filter { $0.imageUrl != nil }
            return .success(cards)
        } catch{
            return .failure(error)
        }
    }
    struct MagicResponse: Codable{
        let cards: [Card]
        
    }
    public var baseURL: URL {
        return URL(string:"https://api.magicthegathering.io/v1/")!
    }
    
    
    public var path: String {
        switch self {
        case .cards: return "/cards"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self{
        case .cards:
            return .requestPlain
            
        }
        
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
      }
    
}
