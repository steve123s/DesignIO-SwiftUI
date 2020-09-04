//
//  DataStore.swift
//  02
//
//  Created by Daniel E. Salinas on 2020/4/8.
//  Copyright © 2020 Daniel E. Salinas. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts{ (posts) in
            self.posts = posts
        }
    }
}
