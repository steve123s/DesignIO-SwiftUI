//
//  Data.swift
//  02
//
//  Created by Daniel E. Salinas on 2020/4/8.
//  Copyright © 2020 Daniel E. Salinas. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable {
    var id = UUID()
    var title: String
    var body: String
}

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            DispatchQueue.main.sync {
                completion(posts)
            }
        }
        .resume()
    }
}
