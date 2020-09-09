//
//  LoginView.swift
//  DesignSwiftUI
//
//  Created by Daniel Esteban Salinas on 08/09/20.
//  Copyright © 2020 com.danielsalinas.designcode. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong."
    @State var isLoading = false
    @State var isSuccessful = false
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func login() {
        
        self.hideKeyboard()
        self.isFocused = false
        self.isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.isLoading = false
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
            } else {
                self.isSuccessful = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.isSuccessful = false
                    self.email = ""
                    self.password = ""
                }
            }
        }
        
    }
    
    var body: some View {
        
        ZStack {
            ZStack(alignment: .top) {
                    Color.black.edgesIgnoringSafeArea(.all)
                
                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                CoverView()
                
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.1), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("Your Email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                                self.hideKeyboard()
                            }
                    }
                    
                    Divider().padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.1), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Password".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                                self.hideKeyboard()
                            }
                    }
            
                }
                .frame(height: 136)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.3882352941, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                .padding(.horizontal, 16)
                .offset(y: 460)
                
                HStack {
                    Text("Forgot password?")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Button(action: {
                        self.login()
                    }) {
                        Text("Log in".uppercased())
                            .foregroundColor(.black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message:
                                Text(self.alertMessage), dismissButton:
                                .default(Text("OK")))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
                
            }
            .offset(y: isFocused ? -300 : 0)
            .animation(isFocused ? .easeInOut : nil)
                    .onTapGesture {
                        self.isFocused = false
                        self.hideKeyboard()
                    }
            if isLoading {
                LoadingView()
            }
            
            if isSuccessful {
               SuccessView()
            }
            
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CoverView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn design & code.\nFrom scratch.")
                    .font(.system(size: geometry.size.width/10, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .offset(x: viewState.width/15, y: viewState.height/15)
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.horizontal, 16)
            
            Text("80 hours of courses for SwiftUI, React and design tools.")
                .font(.subheadline)
                .frame(width: 250)
                .multilineTextAlignment(.center)
                .offset(x: viewState.width/20, y: viewState.height/20)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .opacity(0.5)
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    .onAppear { self.show = true }
                
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .opacity(0.5)
                    .offset(x: -200, y: -250)
                    .blendMode(.overlay)
                    .rotationEffect(Angle(degrees: show ? 360 : 0), anchor: .leading)
                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
            }
        )
        .background(Image(uiImage: #imageLiteral(resourceName: "Card3")).offset(x: viewState.width/25, y: viewState.height/25), alignment: .bottom)
        .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.height, y: viewState.width, z: 0))
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.viewState = value.translation
                    self.isDragging = true
                }
                .onEnded { value in
                    self.viewState = .zero
                    self.isDragging = false
                }
        )
    }
}
