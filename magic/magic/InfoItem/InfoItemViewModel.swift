//
//  InfoItemViewModel.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 6/5/21.
//

import Foundation
import Combine

class InfoItemViewModel: ObservableObject {
    private let model: Card
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init(model: Card) {
        self.model = model
    }
}

extension InfoItemViewModel {
    var name: String { return  "\(model.name)"}
    var descr: String { return "\(model.descr)"}
    var imageURL: URL { return model.imageUrl!}
    var row: Int { return 0}
    var infoItemPresenter: InfoItemPresenter { return InfoItemPresenter() }
    var dataModel: Model { return Model() }
    
    func fetch() {
        objectWillChange.send()
    }
    
}
