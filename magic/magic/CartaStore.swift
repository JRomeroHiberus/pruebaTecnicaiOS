//
//  CartaStore.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import Foundation

class CartaStore {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    
    func fetchCards(completion: @escaping (Result<[Item] , Error>) -> Void){
        let url = MagicAPI.fullURL
        let request = URLRequest(url:url)
        let task = session.dataTask(with: request){
            (data,response,error) in
            
            let result = self.processCardsRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    private func processCardsRequest(data: Data?, error: Error?) -> Result<[Item], Error> {
        guard let jsonData = data else{
            return .failure(error!)
        }
        
        return MagicAPI.cards(fromJSON: jsonData)
    }
}
