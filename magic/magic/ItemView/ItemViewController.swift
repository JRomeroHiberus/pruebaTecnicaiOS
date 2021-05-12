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
    var model = Model()
    var cartaStore: CardStore = CardStore()
    let provider = MoyaProvider<MagicAPI>()
    let jsonDecoder = JSONDecoder()
    var currentPage = 1
    var isFetchInProgress = false
    var presenter: Presenter?
    
    struct Card {
        var name = ""
        var originalText = ""
        
        init(name: String, descr: String) {
            self.name = name
            self.originalText = descr
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.itemData.itemStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = model.itemData.itemStorage[indexPath.row]
        cell.cellLabel.frame.size.width = 320
        cell.cellLabel.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == model.itemData.itemStorage.count - 3 {
            presenter?.fetchCards()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableV.dataSource = self
        tableV.delegate = self
        tableV.rowHeight = UITableView.automaticDimension
        tableV.estimatedRowHeight = 65
        tableV.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        self.presenter = Presenter()
        self.presenter?.view = self
        self.presenter?.interactor = Interactor()
        self.presenter?.interactor?.presenter = self.presenter
        self.presenter?.routing = Routing()
        presenter?.fetchCards()
    }
    
    func refresh() {
        DispatchQueue.main.async(
            execute: {
                self.tableV.reloadData()
            }
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showCard":
            if let row = tableV.indexPathForSelectedRow?.row {
                var infoItemController = segue.destination as! InfoItemController
                infoItemController = presenter!.openItemDetailView(infoItemController: infoItemController, row: row, itemView: self)
            }
        default: preconditionFailure("Unexpected segue identifier")
        }
    }
    
    func setListWithItems(cards: ItemData) {
        self.model.itemData = cards
        refresh()
    }
}
