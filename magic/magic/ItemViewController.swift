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
            print("ahora muestro")
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
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        
        
        
        itemData = ItemData()
        cartaStore = CartaStore()
       /* for _ in 0...5 {
            itemData.crearItem()
        }
        for i in 0...5 {
            print(itemData.almacenItems[i])
        }*/
        //cartaStore.fetchCards()
        cartaStore.fetchCards{
            (cardsResult) in
            switch cardsResult{
            case let .success(items):
                print("fetch correcto: encontradas \(items.count) cartas")
                for i in items {
                    self.itemData.addItem(item: i)
                    print("Ahora almaceno")
                   // print (" Hay \(self.itemData.almacenItems.count) cartas en itemData")
                }
                self.refresh()
            case let .failure(error):
                print("error haciendo el fetch 1 \(error)")
            }
        }
    
        
    }
    
    func refresh(){
        DispatchQueue.main.async(
            execute:
            {
                print("Ejecuto refresh")
                self.tableView.reloadData()
            })
    }

}
