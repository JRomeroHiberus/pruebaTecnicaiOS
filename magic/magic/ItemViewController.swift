//
//  ItemViewController.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 19/4/21.
//

import UIKit

class ItemViewController: UITableViewController {
    var itemData : ItemData!
    var cartaStore: CartaStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return itemData.almacenItems.count
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemData.almacenItems[indexPath.row]
        cell.TextoCell.text = item.name
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemData = ItemData()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        cartaStore = CartaStore()
       /* for _ in 0...5 {
            itemData.crearItem()
        }
        for i in 0...5 {
            print(itemData.almacenItems[i])
        }*/
        
        cartaStore.fetchCards{
            (cardsResult) in
            switch cardsResult{
            case let .success(item):
                print("fetch correcto")
            case let .failure(error):
                print("error haciendo el fetch")
            }
        }
    }
    
    
    
    
    
}
