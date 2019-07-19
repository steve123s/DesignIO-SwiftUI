//
//  CertificateRow.swift
//  DesignCodeIO
//
//  Created by Daniel Esteban Salinas on 19/07/19.
//  Copyright © 2019 Daniel Esteban Salinas. All rights reserved.
//

import SwiftUI

struct CertificateRow : View {
    var certificates = certificateData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Certificates")
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .padding(.leading, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(certificates) { item in
                        CertificateView(item: item)
                    }
                }
                .padding(20)
                .padding(.horizontal, 10)
        }
    }
    }
}

#if DEBUG
struct CertificateRow_Previews : PreviewProvider {
    static var previews: some View {
        CertificateRow()
    }
}
#endif

struct Certificate: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var width: Int
    var height: Int
}
let certificateData = [
    Certificate(title: "UI Design", image: "Certificate1", width: 230, height: 150),
    Certificate(title: "SwiftUI", image: "Certificate2", width: 230, height: 150),
    Certificate(title: "Sketch", image: "Certificate3", width: 230, height: 150),
    Certificate(title: "Framer", image: "Certificate4", width: 230, height: 150)
]
