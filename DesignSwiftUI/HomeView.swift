//
//  HomeView.swift
//  01
//
//  Created by Daniel E. Salinas on 2020/4/5.
//  Copyright © 2020 Daniel E. Salinas. All rights reserved.
//

import SwiftUI

func getAngleMultiplier(bounds: GeometryProxy) -> Double {
    if bounds.size.width > 500 {
        return 80
    } else {
        return 20
    }
}

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    @Binding var viewState: CGSize
    @State var courses = courseData
    //@ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @State var isScrollable = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader { bounds in
            ScrollView {
                VStack {
                    HStack {
                        Text("Watching")
                            .font(.system(size: 28, weight: .bold))
                            //.modifier(CustomFontModifier(size: 34))
                        
                        Spacer()
                        AvatarView(showProfile: $showProfile)
                        
                        Button(action: {self.showUpdate.toggle()}) {
                            Image(systemName: "bell")
                                //.renderingMode(.original)
                                .foregroundColor(.primary)
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 36, height: 36)
                                .background(Color("background3"))
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        }
                        .sheet(isPresented: $showUpdate) {
                            UpdateList()
                        }
                    }
                    .blur(radius: self.active ? 20 : 0)
                    .padding(.horizontal)
                    .padding(.leading, 14)
                    .padding(.top, 30)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        WatchRingsView()
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                            .onTapGesture {
                                self.showContent = true
                            }
                    }
                    .blur(radius: self.active ? 20 : 0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(sectionData) { item in
                                GeometryReader { geometry in
                                    SectionView(section: item)
                                        .rotation3DEffect(Angle(degrees:
                                                Double(geometry.frame(in: .global).minX) - 30) / -getAngleMultiplier(bounds: bounds),
                                                    axis: (x: 0, y: 10, z: 0))
                                }
                                .frame(width: 275, height: 275)
                            }
                        }
                        .padding(30)
                        .padding(.bottom, 30)
                    }
                    .blur(radius: self.active ? 20 : 0)
                    .offset(y: -30)
                    
                    HStack {
                        Text("Courses")
                            .font(.title).bold()
                        Spacer()
                    }
                    .blur(radius: self.active ? 20 : 0)
                    .padding(.leading, 30)
                    .offset(y: -60)
                    
                    SectionView(section: sectionData[2], width: bounds.size.width, height: 275)
                    Spacer()
                }
                .frame(width: bounds.size.width)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .disabled(self.active && !self.isScrollable ? true : false)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false),
                    viewState: .constant(CGSize.zero))
                .environmentObject(UserStore())
    }
}

struct SectionView: View {
    
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.tittle)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                Spacer()
                Image(section.logo)
            }
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: Color("card1").opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var tittle: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(tittle: "Prototype design in SwiftUI", text: "18 Section", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
    Section(tittle: "Build a SwiftUI app", text: "20 Section", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
    Section(tittle: "SwiftUI Advanced", text: "20 Section", logo: "Logo1", image: Image("Card1"), color: Color("card1"))
]

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 68, show: .constant(true))
                VStack(alignment: .leading, spacing: 4) {
                    Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
                    Text("watch 10 mins today").modifier(FontModifier(style: .caption))
                }
                .modifier(FontModifier())
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), color2: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), width: 32, height: 32, percent: 80, show: .constant(true))
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), width: 32, height: 32, percent: 80, show: .constant(true))
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
