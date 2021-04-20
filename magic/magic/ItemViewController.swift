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
        return itemData.almacenItems.count
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemData.almacenItems[indexPath.row]
        cell.TextoCell.text = item.name
        
        return cell
    }
    
    func get_data(_ link: String){
        let url = URL(string: link)!
        let session = URLSession.shared
        
        let request = URLRequest(url:url)
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            print (link)
            self.extract_data(data)
        })
    }
    
    func extract_data(_ data: Data?){
        
        let json:Any?
        guard data != nil else{
            print("Me voy")
            return
        }
        print("No me voy")
        do{
              json = try JSONSerialization.jsonObject(with: data!, options: [])
        }
        catch{
            
            return
        }
        
        guard let data_array = json as? NSArray else {
            
            return
        }
        
        for i in 0 ..< data_array.count {
            if let data_object = data_array[i] as? NSDictionary {
                if let data_code = data_object["name"] as? String, let data_descr = data_object["originalText"] as? String {
                        print(data_code,data_descr)
                        let itemAux = Carta(name: data_code, descr: data_descr)
                        itemData.crearItem(item:itemAux)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemData = ItemData()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
      //  get_data("https://api.magicthegathering.io/v1/cards")
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
            case let .success(item):
                print("fetch correcto")
            case let .failure(error):
                print("error haciendo el fetch 1 \(error)")
            }
        }
        
    }
    
    
    
    
    
}
