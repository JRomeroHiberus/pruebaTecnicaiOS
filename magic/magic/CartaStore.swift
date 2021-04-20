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
    
    //func fetchCards(){
    func fetchCards(completion: @escaping (Result<[Carta] , Error>) -> Void){
        let url = MagicAPI.fullURL
        let request = URLRequest(url:url)
        let task = session.dataTask(with: url){
            (data,response,error) in
            /*if let jsonData = data {
                if let jsonString = String(data: jsonData,encoding: .utf8){
                print(jsonString)
                }
            } else if let requestError = error {
                        print("Error fetching interesting photos: \(requestError)")
            } else {
                        print("Unexpected error with the request")
                    }*/
            
            
            
            let result = self.processCardsRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    private func processCardsRequest(data: Data?, error: Error?) -> Result<[Carta], Error> {
        guard let jsonData = data else{
            print("Error aqui")
            return .failure(error!)
        }
        
        return MagicAPI.cards(fromJSON: jsonData)
    }
}
