//
//  InputOutput.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 28/4/21.
//

import Foundation

protocol InteractionProtocolInput{
    func addNewCardWithData(name: String, descr:String, url:String)
}


protocol InteractionProtocolOutput{
    func updateItems(items: [Card])
}
