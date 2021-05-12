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
import RxSwift
import RxCocoa

class ItemViewController: UIViewController, UIScrollViewDelegate {
   
    @IBOutlet var tableV: UITableView!
    let viewModel: ItemViewModel = ItemViewModel()
    var model = Model()
    var cartaStore: CardStore = CardStore()
    private var cancellables: Set<AnyCancellable> = []
    let provider = MoyaProvider<MagicAPI>()
    let jsonDecoder = JSONDecoder()
    var currentPage = 1
    var isFetchInProgress = false
    private var cards = [Card]()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableV.dataSource = self
        tableV.rx.setDelegate(self).disposed(by: bag)
        tableV.rowHeight = UITableView.automaticDimension
        tableV.estimatedRowHeight = 65
        setUpBindings()
        setData()
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
                infoItemController.card = cards[row]
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
   
    private func setUpBindings() {
        tableV.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        
        viewModel.itemData.bind(
            to: tableV.rx.items(cellIdentifier: "ItemCell", cellType: ItemCell.self)) { _, item, cell in
            cell.textLabel?.text = item.name
        }.disposed(by: bag)
        
        tableV.rx.modelSelected(Card.self).subscribe(onNext: {
            [self] card in
            self.performSegue(withIdentifier: "showCard", sender: card)
        }).disposed(by: bag)
        
        viewModel.fetchCards()
        
    }
    
    private func setData() {
        return viewModel.itemData
            .subscribe(
                onNext: { cards in
                    self.cards = cards
                    self.refresh()
                },
                onCompleted: {}
            ).disposed(by: bag)
    }
    
}
