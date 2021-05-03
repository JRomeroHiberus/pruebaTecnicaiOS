//
//  Protocols.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 30/4/21.
//

import Foundation

import UIKit

protocol InteractorInput {
    func showCardsRequest()
}

protocol InteractorOutput {
    func updateObject(itemData: ItemData)
}
