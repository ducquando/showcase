//
//  LogInScreen.swift
//  Showcase
//
//  https://stackoverflow.com/questions/61064951/swiftui-button-login-authentication-and-go-to-new-view
//  Created by quannz on 29/05/2022.
//

import SwiftUI

/// Structure represents the log in screen view
struct LogInScreen: View {
    /// Inputed email
    /// Changes when user type
    @State private var email: String = ""
    /// Inputed password
    /// Changes when user type
    @State private var password: String = ""
    /// Whether showing the log-in fail error
    @State private var showAlert: Bool = false
    
    /// Log-in status
    @Binding var logInSuccess: Bool   // False, by default
    /// Logged user id
    @Binding var userID: String       // Empty string, by default
    
    /// This struct's view body
    var body: some View {
        VStack {
            // App's name
            Text("Showcase")
                .logoStyle()
                .padding(.bottom)
            
            // Inputed fields
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .textBoxLogInStyle()
            SecureField("Password", text: $password)
                .padding()
                .textBoxLogInStyle()
            
            // Sign-in button
            // Clickable on the whole area and will trigger the change of
            // view if inputed email & password are valid
            Button (action: {
                // Determine login validity
                let fetchDB = QueryDB()
                let defaultUserID = ""
                
                // If there is a return user's id, switch content
                userID = fetchDB.queryUserID(email: self.email,
                                             pass: self.password)
                if userID != defaultUserID {
                    self.logInSuccess = true // Trigger view switch
                } else {
                    self.showAlert = true    // Trigger alert
                }
            }) {
                Text("Sign in")
                    .buttonLogInStyle()
            }
            .padding(.top)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Email/Password incorrect"))
            }
        }
    }
}
