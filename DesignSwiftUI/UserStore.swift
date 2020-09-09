//
//  UserStore.swift
//  DesignSwiftUI
//
//  Created by Daniel Esteban Salinas on 09/09/20.
//  Copyright © 2020 com.danielsalinas.designcode. All rights reserved.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
}
