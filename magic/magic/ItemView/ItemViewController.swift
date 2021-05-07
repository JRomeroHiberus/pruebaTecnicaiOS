//
//  ItemViewController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit
import Kingfisher
import Moya
import Combine

class ItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, viewProtocol {
   
    @IBOutlet var tableV: UITableView!
    let viewModel: ItemViewModel = ItemViewModel()
    var model = Model()
    var cartaStore: CardStore = CardStore()
    private var cancellables: Set<AnyCancellable> = []
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
        return viewModel.itemData.itemStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = viewModel.itemData.itemStorage[indexPath.row]
        cell.cellLabel.frame.size.width = 320
        cell.cellLabel.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.itemData.itemStorage.count - 3 {
            viewModel.fetchCards()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableV.dataSource = self
        tableV.delegate = self
        tableV.rowHeight = UITableView.automaticDimension
        tableV.estimatedRowHeight = 65
        tableV.register(ItemCell.self, forCellReuseIdentifier: "itemCell")
        bindViewModel()
        viewModel.fetchCards()
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
                // infoItemController = presenter!.openItemDetailView(infoItemController: infoItemController, row: row, itemView: self)
                bindOpenDetailViewModel()
                infoItemController = viewModel.openDetailViewController(infoItem: infoItemController, row: row)
             
            }
        default: preconditionFailure("Unexpected segue identifier")
        }
    }
    
    func setListWithItems(cards: ItemData) {
        self.model.itemData = cards
        refresh()
    }
    
    private func bindViewModel() {
        viewModel.itemChanged.sink { [weak self] in
        
            guard self != nil else {
                return
            }
            self?.refresh()
        }.store(in: &cancellables)
        
    }
    
    private func bindOpenDetailViewModel() {
        viewModel.itemChanged.sink { [weak self] in
        
            guard self != nil else {
                return
            }
            self?.refresh()
        }.store(in: &cancellables)
        
    }
    
}
