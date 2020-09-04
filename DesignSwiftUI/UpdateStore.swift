//
//  UpdateStore.swift
//  01
//
//  Created by Daniel E. Salinas on 2020/4/6.
//  Copyright © 2020 Daniel E. Salinas. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
