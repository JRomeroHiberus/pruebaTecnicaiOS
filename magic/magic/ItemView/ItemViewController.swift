//
//  ItemViewController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit
import Kingfisher
import Moya

class ItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, viewProtocol {
    
    @IBOutlet var tableV: UITableView!
    var itemData: ItemData = ItemData(cardStorage: [])
    var cartaStore: CardStore = CardStore()
    let provider = MoyaProvider<MagicAPI>()
    let jsonDecoder = JSONDecoder()
    var currentPage = 1
    var isFetchInProgress = false
    var presenter: Presenter?
    // var routing: Routing?
    
    struct Card {
        var name = ""
        var originalText = ""
        
        init(name: String, descr: String) {
            self.name = name
            self.originalText = descr
            
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemData.itemStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // let item = itemData.itemStorage[indexPath.row]
        let item = itemData.itemStorage[indexPath.row]
        
        cell.cellLabel.frame.size.width = 320
        cell.cellLabel.text = item.name
        
        return cell
    }
    
   /* func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == itemData.itemStorage.count - 1 {
            presenter?.fetchCards()
        }
    }*/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableV.dataSource = self
        tableV.delegate = self
        tableV.rowHeight = UITableView.automaticDimension
        tableV.estimatedRowHeight = 65
        tableV.register(ItemCell.self, forCellReuseIdentifier: "itemCell")
        
        self.presenter = Presenter()
        self.presenter?.view = self
        self.presenter?.interactor = Interactor()
        // presenter.routing = self
        self.presenter?.interactor?.presenter = self.presenter
        
       // self.routing = Routing()
      
        print("Voy a avisar a presenter")
        presenter?.fetchCards()
        print("Ya he avisado")
        
    }
    
    func refresh() {
        DispatchQueue.main.async(
            execute: {
                
                self.tableV.reloadData()
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "showCard":
            if let row = tableV.indexPathForSelectedRow?.row {
                let infoItemController = segue.destination as! InfoItemController
               // interactor.showCardRequest(index)
               /* let card = itemData.itemStorage[row]
                infoItemController.card = card*/
                infoItemController.row = row
            }
        default: preconditionFailure("Unexpected segue identifier")
        }
    }
    
   /* private func calculateIndexPathsToReload(from newCards: [Card]) -> [IndexPath] {
      let startIndex = itemData.itemStorage.count - newCards.count
      let endIndex = startIndex + newCards.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }*/
    
    /*func fetchCards() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        provider.request(.cards(page: currentPage)) { result in
            
            switch result {
            case .success(let response):
                do {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    let magicResponse = try self.jsonDecoder.decode(MagicAPI.MagicResponse.self, from: response.data)
                    let cards = magicResponse.cards.filter { $0.imageUrl != nil }
                    for card in cards {
                        self.itemData.addItem(item: card)
                    }
                    self.refresh()
                } catch {
                    print(error)
                }
            case .failure(let error):
                    self.isFetchInProgress = false
                    print(error)
            }
            
        }
        
    }*/
    
    func setListWithItems(cards: ItemData) {
        self.itemData = cards
        refresh()
    }
}
