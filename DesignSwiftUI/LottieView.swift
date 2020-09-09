//
//  LottieView.swift
//  DesignSwiftUI
//
//  Created by Daniel Esteban Salinas on 09/09/20.
//  Copyright © 2020 com.danielsalinas.designcode. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
}
