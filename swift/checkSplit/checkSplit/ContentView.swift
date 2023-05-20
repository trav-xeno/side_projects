//
//  ContentView.swift
//  checkSplit
//
//  Created by Travis Nevins on 5/20/23.
//

import SwiftUI

//will update further tomorrow
struct ContentView: View {
    @State var tapCount: Int = 0
    @State private var username: String = ""
    @FocusState private var usernameFieldIsFocused: Bool
    @State private var vaildInput: Bool = true
    
   private func validate(name: String) {
        let validUsers = ["Lindon", "Yarin", "Mathis","Alyx"]
       if username.count == 0 {
           return
       }
       if !validUsers.contains(name){
            vaildInput = false
        } else {
            vaildInput = true
        }
        
    }
    
    var body: some View {
        Text("Check split!")
            .font(.largeTitle)
        Spacer()
        Text("tap \(tapCount)")
        Button("Tap Count: \(tapCount)") {
            tapCount += 1
        }.padding()
            .foregroundColor(Color.white)
            .background(Color.indigo)
        Section {
            Form {
                TextField(
                    "User name",
                    text: $username
                )
                .focused($usernameFieldIsFocused)
                .onSubmit {
                    validate(name: username)
                    
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                Text(username)
                    .foregroundColor(usernameFieldIsFocused ? .green : .blue)
                if !vaildInput {
                    Text("not valid user. Try Mathis")
                        .font(.largeTitle)
                        .foregroundColor(Color.red)
                }else {
                        Text(" Good to go ☑️" )
                        .foregroundColor(Color.green)
                }
                    
            }
        }
    }
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
