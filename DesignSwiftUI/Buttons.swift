//
//  Buttons.swift
//  DesignSwiftUI
//
//  Created by Daniel Esteban Salinas on 07/09/20.
//  Copyright © 2020 com.danielsalinas.designcode. All rights reserved.
//

import SwiftUI

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

struct Buttons: View {
    
    var body: some View {
        VStack(spacing: 50) {
            RectangleButton()
            CircleButton()
            PayButton()
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

struct RectangleButton: View {
    @State var tap = false
    @State var press = false
    
    var body: some View {
        Text("Button")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60)
            
            .background(
                ZStack {
                    Color(press ? #colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(Color( press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)))
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            
            .scaleEffect(tap ? 1.2 : 1)
            .gesture(
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 10)
                    .onChanged { value in
                        self.tap = true
                        impact(style: .heavy)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tap = false
                        }
                    }
                    .onEnded { value in
                        self.press.toggle()
                        haptic(type: .success)
                    }
            )
            
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            
            .overlay(
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(Color.white.opacity(press ? 0 : 1))
                        .frame(width: press ? 64 : 54, height: press ? 4 : 50)
                        .background(Color(#colorLiteral(red: 0.4196078431, green: 0.2980392157, blue: 0.9490196078, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0.4196078431, green: 0.2980392157, blue: 0.9490196078, alpha: 1)).opacity(0.5), radius: 10, x: 10, y: 10)
                        .offset(x: press ? 70 : -10, y: press ? 16 : 0)
                    Spacer()
                }
            )
            
            .shadow(color: press ? Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1)) : Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
            .shadow(color: press ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
    }
}

struct CircleButton: View {
    @State var tap = false
    @State var press = false

    var body: some View {
        ZStack {
            Image(systemName: "sun.max")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ? -90 : 0, y: press ? -90 : 0)
                .rotation3DEffect(Angle(degrees: press ? 20 : 0), axis: (x: 10, y: 10, z: 0))
            Image(systemName: "moon")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ? 0 : 90, y: press ? 0 : 90)
                .rotation3DEffect(Angle(degrees: press ? 0 : 20), axis: (x: 10, y: 10, z: 0))
        }
        .frame(width: 100, height: 100)
        
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(press ? #colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                Circle()
                    .shadow(color: Color(#colorLiteral(red: 0.7256438732, green: 0.7787529826, blue: 0.8831245303, alpha: 1)), radius: press ? 10 : 3, x: press ? 5 : -5, y: press ? 5 : -5)
                Circle()
                    .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: press ? -3 : 3, y: press ? -3 : 3)
            }
        )
        
        .background(Color.white)
        .clipShape(Circle())
        .shadow(color: press ? Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1)) : Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
        .shadow(color: press ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
        scaleEffect(tap ? 1.2 : 1)
        
        .gesture(
            LongPressGesture().onChanged { value in
                self.tap = true
                impact(style: .heavy)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.tap = false
                }
            }
            .onEnded { value in
                self.press.toggle()
                haptic(type: .success)
            }
        )
        
    }
}

struct PayButton: View {
    @GestureState var tap = false
    @State var press = false

    var body: some View {
        ZStack {
            Image("Logo1")
                .scaleEffect(press ? 0 : 1)
                .opacity(press ? 0: 1)
            
            Image("Logo2")
                .clipShape(Rectangle().offset(y: tap ? 1 : 50))
                .scaleEffect(press ? 0 : 1)
                .opacity(press ? 0: 1)
            
            Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 44, weight: .light))
                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                    .opacity(press ? 1 : 0)
                    .scaleEffect(press ? 1 : 0)
        }
        .frame(width: 120, height: 120)
        
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(press ? #colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                Circle()
                    .shadow(color: Color(#colorLiteral(red: 0.7256438732, green: 0.7787529826, blue: 0.8831245303, alpha: 1)), radius: press ? 10 : 3, x: press ? 5 : -5, y: press ? 5 : -5)
                Circle()
                    .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: press ? -3 : 3, y: press ? -3 : 3)
            }
        )
        
        .background(Color.white)
        .clipShape(Circle())
        
        .overlay(
            Circle()
            .trim(from: tap ? 0.001 : 1, to: 1)
            .stroke(
                LinearGradient(gradient: Gradient(colors: [Color(press ? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.4196078431, green: 0.2980392157, blue: 0.9490196078, alpha: 1)), Color(press ? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
            )
            .frame(width: 88, height: 88)
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .shadow(color: Color(press ? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.4196078431, green: 0.2980392157, blue: 0.9490196078, alpha: 1)).opacity(0.3), radius: 5, x: 3, y: 3)
            .animation(.easeInOut)
        )
        
        .shadow(color: press ? Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1)) : Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
        .shadow(color: press ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
        scaleEffect(tap ? 1.2 : 1)
        
        .gesture(
            LongPressGesture().updating($tap) { currentState, gestureState, transaction in
                gestureState = currentState
                impact(style: .light)
            }
            .onEnded { value in
                self.press.toggle()
                haptic(type: .success)
            }
        )
        
    }
}
