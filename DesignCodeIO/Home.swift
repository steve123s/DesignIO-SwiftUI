//
//  Home.swift
//  DesignCodeIO
//
//  Created by Daniel Esteban Salinas on 16/07/19.
//  Copyright © 2019 Daniel Esteban Salinas. All rights reserved.
//

import SwiftUI

let statusBarHeight = UIApplication.shared.statusBarFrame.height
let screen = UIScreen.main.bounds

struct Home : View {
    
    @State var show = false
    @State var showProfile = false
    
    
    var body: some View {
        ZStack {
            
            HomeList()
            .blur(radius: show ? 20 : 0)
                .scaleEffect(showProfile ? 0.95 : 1)
            .animation(.default)
            
            ContentView()
                .frame(minWidth: 0, maxWidth: 712)
                .cornerRadius(30)
                .shadow(radius: 20)
                .animation(.fluidSpring())
                .offset(y: showProfile ? statusBarHeight + 40 : UIScreen.main.bounds.height)
            
            MenuButton(show: $show)
                .offset(x: -40, y: showProfile ? statusBarHeight : 80)
                .animation(.fluidSpring())
            
            MenuRight(show: $showProfile)
                .offset(x: -16, y: showProfile ? statusBarHeight : 88)
                .animation(.fluidSpring())
            
            MenuView(show: $show)
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct Home_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            Home().previewDevice("iPhone SE")
            Home().previewDevice("iPhone Xr")
            Home().previewDevice("iPad Pro (9.7-inch)")
        }
    }
}
#endif

struct MenuRow : View {
    var image = "creditcard"
    var text = "My Account"
    var body: some View {
        return HStack {
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(Color("icons"))
                .frame(width: 32, height: 32)
            Text(text)
                .color(.primary)
                .font(.headline)
            Spacer()
        }
    }
}

struct Menu : Identifiable {
    var id = UUID()
    var title: String
    var icon: String
}

let menuData = [
    Menu(title: "My Account", icon: "person.crop.circle"),
    Menu(title: "Settings", icon: "gear"),
    Menu(title: "Billing", icon: "creditcard"),
    Menu(title: "Team", icon: "person.and.person"),
    Menu(title: "Sign Out", icon: "arrow.uturn.down")

]

struct MenuView : View {
    
    var menu = menuData
    @Binding var show: Bool
    
    var body: some View {
        
        return HStack {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(menu) { item in
                    if item.title == "Settings" {
                        PresentationLink(destination: Settings()) {
                            MenuRow(image: item.icon, text: item.title)
                        }
                    } else {
                        MenuRow(image: item.icon, text: item.title)
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
            .padding(30)
            .frame(minWidth: 0, maxWidth: 360)
            .background(Color("button"))
            .cornerRadius(30)
            .padding(.trailing, 60)
            .shadow(radius: 20)
            .rotation3DEffect(Angle(degrees: show ? 0 : 90), axis: (x: 0.0, y: 10.0, z: 0.0))
            .animation(.basic())
            .offset(x: show ? 0 : -UIScreen.main.bounds.width)
            .tapAction {
                self.show.toggle()
            }
            Spacer()
        }
        .padding(.top, statusBarHeight)
    }
}

struct CircleButton : View {
    var icon = "person.crop.circle"
    var body: some View {
        return HStack {
            Image(systemName: icon)
                .foregroundColor(.primary)
        }
        .frame(width: 44, height: 44)
        .background(Color("button"))
        .cornerRadius(30)
        .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
}
}

struct MenuButton : View {
    @Binding var show: Bool
    var body: some View {
        return ZStack(alignment: .topLeading) {
            Button(action: {self.show.toggle() } ) {
                HStack {
                    Spacer()
                    Image(systemName: "list.dash")
                        .foregroundColor(.primary)
                }
                .padding(.trailing, 18)
                .frame(width: 90, height: 60)
                .background(Color("button"))
                .cornerRadius(30)
                .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
            }
            Spacer()
        }
    }
}

struct MenuRight : View {
    @Binding var show: Bool
    var body: some View {
        return ZStack(alignment: .topTrailing) {
            HStack {
                Button(action: { self.show.toggle() }) {
                    CircleButton(icon: "person.crop.circle")
                }
                PresentationLink(destination: UpdateList()) {
                    CircleButton(icon: "bell")
                }
            }
            Spacer()
        }
    }
}
