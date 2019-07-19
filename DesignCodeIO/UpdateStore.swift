//
//  UpdateStore.swift
//  DesignCodeIO
//
//  Created by Daniel Esteban Salinas on 19/07/19.
//  Copyright © 2019 Daniel Esteban Salinas. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    var updates: [Update] {
        didSet {
            didChange.send()
        }
    }
    
    init(updates: [Update] = []) {
        self.updates = updates
    }
}
