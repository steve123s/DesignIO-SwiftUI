//
//  Settings.swift
//  DesignCodeIO
//
//  Created by Daniel Esteban Salinas on 19/07/19.
//  Copyright © 2019 Daniel Esteban Salinas. All rights reserved.
//

import SwiftUI

struct Settings : View {
    @State var recieve = false
    @State var number = 1
    @State var selection = 1
    @State var date = Date()
    @State var email = ""
    @State var submit = false
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $recieve) {
                    Text("Recieve Notifications")
                }
                Stepper(value: $number, in: 1...10) {
                    Text("\(number) Notification\(number > 1 ? "s" : "") per week")
                }
                Picker(selection: $selection, label: Text("Favorite course")) {
                    Text("SwiftUI").tag(1)
                    Text("React").tag(2)
                }
                DatePicker($date) {
                    Text("Date")
                }
                Section(header: Text("Email"), content: {
                    TextField("Your email", text: $email)
                        .textFieldStyle(.roundedBorder)
                })
                Button(action: { self.submit.toggle() }, label: {
                    Text("Submit")
                })
                    .presentation($submit, alert: {
                        Alert(title: Text("Thanks!"), message: Text("Email: \(email)"))
                    })
            }
            .navigationBarTitle("Settings")
        }
    }
}

#if DEBUG
struct Settings_Previews : PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
#endif
