//
//  LoadingView.swift
//  DesignSwiftUI
//
//  Created by Daniel Esteban Salinas on 09/09/20.
//  Copyright © 2020 com.danielsalinas.designcode. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(filename: "cat")
                .frame(width: 200, height: 200)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
