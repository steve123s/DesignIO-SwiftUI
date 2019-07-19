//
//  HomeList.swift
//  DesignCodeIO
//
//  Created by Daniel Esteban Salinas on 19/07/19.
//  Copyright © 2019 Daniel Esteban Salinas. All rights reserved.
//

import SwiftUI

struct HomeList : View {
    var courses = coursesData
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Courses")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            Text("22 courses")
                                .color(.gray)
                        }
                        Spacer()
                    }
                    .padding(.leading, 60.0)
                
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(courses) { item in
                                PresentationLink(destination: ContentView()) {
                                    GeometryReader { geometry in
                                        CourseView(title: item.title,
                                        image: item.image,
                                        color: item.color,
                                        shadow: item.shadow)
                                            .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -40 ), axis: (x: 0, y: 10, z: 0))
                                    }
                                    .frame(width: 246, height: 360)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                        .padding(.bottom, 70)
                    Spacer()
                }
                
                
                CertificateRow()
                
            }
            .padding(.top, 78.0)
    }
        
    }
    
}

#if DEBUG
struct HomeList_Previews : PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}
#endif

struct CourseView : View {
    var title = "Build an app with SwiftUI"
    var image = "Illustration1"
    var color = Color("background3")
    var shadow = Color("backgroundShadow3")
    var body: some View {
        return VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .color(.white)
                .padding(30)
                .lineLimit(4)
                .padding(.trailing, 50)
            Spacer()
            Image(image)
            .resizable()
            .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
            .frame(width: 246, height: 150)
            .padding(.bottom, 30)
        }
        .background(color)
            .cornerRadius(30)
            .frame(width: 246.0, height: 360.0)
            .shadow(color: shadow, radius: 20, x: 0, y: 20)
    }
}

struct Course: Identifiable {
    
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    var shadow: Color
    
}

let coursesData = [
    Course(title: "Build an app with SwiftUI",
           image: "Illustration1",
           color: Color("background3"),
           shadow: Color("backgroundShadow3")),
    Course(title: "Design and animate your UI",
           image: "Illustration2",
           color: Color("background4"),
           shadow: Color("backgroundShadow4")),
    Course(title: "Swift UI Advanced",
           image: "Illustration3",
           color: Color("background7"),
           shadow: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Course(title: "Framer Playground",
           image: "Illustration4",
           color: Color("background8"),
           shadow: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Course(title: "Flutter for Designers",
           image: "Illustration5",
           color: Color("background9"),
           shadow: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5))
]
