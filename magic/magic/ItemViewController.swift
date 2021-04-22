//
//  ItemViewController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit
import Kingfisher
import Moya

class ItemViewController: UITableViewController {
    var itemData : ItemData!
    var cartaStore: CartaStore!
    //var repos = NSArray()
    let provider = MoyaProvider<MagicAPI>()
    let jsonDecoder = JSONDecoder()
    //@IBOutlet var spinner : UIActivityIndicatorView! = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    struct carta {
        var name = ""
        var originalText = ""
        
        init(name: String, descr:String){
            self.name = name
            self.originalText = descr
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        //print (" Hay \(itemData.almacenItems.count) cartas en itemData")
           
             return itemData.almacenItems.count
            

    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemData.almacenItems[indexPath.row]
        cell.TextoCell.text = item.name
        cell.TextoCell.frame.size.width = 320
        
        return cell
    }
    
  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        
        
        
        itemData = ItemData()
       // cartaStore = CartaStore()
       /* for _ in 0...5 {
            itemData.crearItem()
        }
        for i in 0...5 {
            print(itemData.almacenItems[i])
        }*/
        //cartaStore.fetchCards()
        /*cartaStore.fetchCards{
            (cardsResult) in
            switch cardsResult{
            case let .success(items):
                print("fetch correcto: encontradas \(items.count) cartas")
                for i in items {
                    self.itemData.addItem(item: i)
                    
                   // print (" Hay \(self.itemData.almacenItems.count) cartas en itemData")
                }
                self.refresh()
            case let .failure(error):
                print("error haciendo el fetch de la carta \(error)")
            }
        }*/
        provider.request(.cards){ result in
            
            switch result {
            case .success(let response):
                do{
                  
                    let magicResponse = try self.jsonDecoder.decode(MagicAPI.MagicResponse.self, from:response.data)
                    let cards = magicResponse.cards.filter { $0.imageUrl != nil }
                    for i in cards {
                        self.itemData.addItem(item: i)
                    }
                    self.refresh()
                } catch{
                    print(error)
                }
            case .failure:
                print("error")
            }
            
        }
    }
    
    func refresh(){
        DispatchQueue.main.async(
            execute:
            {
                
                self.tableView.reloadData()
            })
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "showCard":
            if let row = tableView.indexPathForSelectedRow?.row {
                let infoItemController = segue.destination as! InfoItemController
               // infoItemController.view.addSubview(spinner)
                let card = itemData.almacenItems[row]
                //let url = card.imageUrl
                /*cartaStore.fetchImage(for: card) {
                    (fotoResult) in
                    switch fotoResult{
                    case let .success(foto):
                        //self.updateFoto(displaying: foto, infoItemController: infoItemController)
                        infoItemController.fotoCarta.image = foto
                        print ("Imagen conseguida correctamente")
                    
                    case let .failure(error):
                        print("error haciendo el fetch de la imagen \(error)")
                        
                    }

                }*/
             
               // infoItemController.fotoCarta.kf.setImage(with: url)
               
                infoItemController.carta = card
            }
        default: preconditionFailure("Unexpected segue identifier")
        }
    }
    
    /*func updateFoto(displaying image: UIImage? , infoItemController: InfoItemController){
        if let imageToDisplay = image {
            spinner.stopAnimating()
            infoItemController.fotoCarta.image = imageToDisplay
        } else {
            spinner.center = infoItemController.fotoCarta.center
            spinner.startAnimating()
            infoItemController.fotoCarta.image = nil
        }
    }*/
    
    
}
