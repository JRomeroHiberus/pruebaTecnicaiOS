//
//  CartaStore.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit

class CardStore {
    
    enum CardError: Error {
        case imageCreationError
        case missingURL
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // func fetchCards(){
    /*func fetchCards(completion: @escaping (Result<[Carta] , Error>) -> Void){
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
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processCardsRequest(data: Data?, error: Error?) -> Result<[Carta], Error> {
        guard let jsonData = data else{
            print("Error aqui")
            return .failure(error!)
        }
        
        return MagicAPI.cards(fromJSON: jsonData)
    }*/
    
    func fetchImage(for card: Card, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let cardURL = card.imageUrl else {
            completion(.failure(CardError.missingURL))
            return
        }
      
        let request = URLRequest(url: cardURL)
        let task = session.dataTask(with: request) { (data, _, error) in
            
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
        guard let imageData = data, let image = UIImage(data: imageData) else {
            if data == nil {
                return .failure(error!)
            } else {
                return .failure(CardError.imageCreationError)
            }
        }
        
        return .success(image)
    }
    
}
