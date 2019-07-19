//
//  TabBar.swift
//  DesignCodeIO
//
//  Created by Daniel Esteban Salinas on 19/07/19.
//  Copyright © 2019 Daniel Esteban Salinas. All rights reserved.
//

import SwiftUI

struct TabBar : View {
    var body: some View {
        TabbedView {
            Home().tabItem({
                Image("IconHome")
                Text("Home")
            })
            .tag(1)
            ContentView().tabItem({
                Image("IconCards")
                Text("Certificates")
            })
            .tag(2)
            Settings().tabItem({
                Image("IconSettings")
                Text("Settings")
            })
            .tag(3)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct TabBar_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            TabBar()
            TabBar()
                .environment(\.colorScheme, .dark)
                .environment(\.sizeCategory, .extraExtraLarge)
        }
    }
}
#endif
