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
    @Published var isLogged = false
        @Published var showLogin = false
}
