//
//  MagicAPI.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import Foundation
import UIKit
import Moya

enum MagicAPI: TargetType {
    case pagination(page: Int)
    case noPagination
    
    static func cards(fromJSON data: Data) -> Result<[Card], Error> {
        do {
            let decoder = JSONDecoder()
            let magicResponse = try decoder.decode(MagicResponse.self, from: data)
            let cards = magicResponse.cards.filter { $0.imageUrl != nil }
            return .success(cards)
        } catch {
            return .failure(error)
        }
    }
    struct MagicResponse: Codable {
        let cards: [Card]
        
    }
    
    public var baseURL: URL {
        return URL(string: "https://api.magicthegathering.io/v1/")!
    }
    
    public var path: String {
        switch self {
        case .pagination, .noPagination: return "/cards"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .pagination(page):
            return .requestParameters(
                parameters: [
                    "page": "\(page)"
                ], encoding: URLEncoding.default
            )
        case .noPagination:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
