//
//  ItemViewController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit
import Kingfisher
import Moya

class ItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate { // UITableViewController{//}, UITableViewDataSourcePrefetching {
    /*func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell){
            fetchCards()
        }
    }
    

     func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.totalCards
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
        
    }*/
    
    @IBOutlet var tableV: UITableView!
    var itemData: ItemData!
    var cartaStore: CardStore!
    // var repos = NSArray()
    let provider = MoyaProvider<MagicAPI>()
    let jsonDecoder = JSONDecoder()
    var currentPage = 1
    var totalCards = 0
    // @IBOutlet var spinner : UIActivityIndicatorView! = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    struct Card {
        var name = ""
        var originalText = ""
        
        init(name: String, descr: String) {
            self.name = name
            self.originalText = descr
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print (" Hay \(itemData.almacenItems.count) cartas en itemData")
        // print("Hay : \()")
             return itemData.itemStorage.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemData.itemStorage[indexPath.row]
        
        cell.cellLabel.frame.size.width = 320
        cell.cellLabel.text = item.name
        
        return cell
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableV.dataSource = self
        tableV.delegate = self
        tableV.rowHeight = UITableView.automaticDimension
        tableV.estimatedRowHeight = 65
        /*let textLabel = UINib(nibName: "ItemCell", bundle: nil)
        tableV.register(textLabel, forCellReuseIdentifier: "itemCell")
        */
        tableV.register(ItemCell.self, forCellReuseIdentifier: "itemCell")
        
        itemData = ItemData()
        fetchCards()
        
    }
    
    func refresh() {
        DispatchQueue.main.async(
            execute: {
                
                self.tableV.reloadData()
            })
    }
    
   /* func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
      
        guard let newIndexPathsToReload = newIndexPathsToReload else {
        tableView.isHidden = false
        tableView.reloadData()
        return
      }
     
      let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
      tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "showCard":
            if let row = tableV.indexPathForSelectedRow?.row {
                let infoItemController = segue.destination as! InfoItemController
               // infoItemController.view.addSubview(spinner)
                let card = itemData.itemStorage[row]
                // let url = card.imageUrl
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
               
                infoItemController.card = card
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
    private func calculateIndexPathsToReload(from newCards: [Card]) -> [IndexPath] {
      let startIndex = itemData.itemStorage.count - newCards.count
      let endIndex = startIndex + newCards.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func fetchCards() {
        provider.request(.cards) { result in
            
            switch result {
            case .success(let response):
                do {
                  
                    let magicResponse = try self.jsonDecoder.decode(MagicAPI.MagicResponse.self, from: response.data)
                    let cards = magicResponse.cards.filter { $0.imageUrl != nil }
                    for card in cards {
                        self.itemData.addItem(item: card)
                    }
                   /* self.totalCards = cards.count
                    self.currentPage += 1
                    if self.currentPage > 1{
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: cards)
                        self.onFetchCompleted(with: indexPathsToReload)
                    }
                    else{
                        self.onFetchCompleted(with: .none)
                    }*/
                    self.refresh()
                } catch {
                    print(error)
                }
            case .failure:
                print("error")
            }
            
        }
        
    }
}
