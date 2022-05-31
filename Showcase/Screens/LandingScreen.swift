//
//  LandingScreen.swift
//  Showcase
//
//  Created by Sada on 27/06/2019 on
//  https://stackoverflow.com/questions/56797333/swiftui-change-view-with-button
//
//  Modified by RanLearns on 31/10/2020, then by quannz on 29/05/2022.
//

import SwiftUI

/// Landing Screen
/// Display the app's content when the user has successfully signed in.
/// Otherwise, show the log-in screen
struct LandingScreen: View {
    /// Whether the sign-in is successful
    @State var logInSuccess = false
    /// This user's id
    @State var userID = ""    // Empty string, by default
    
    /// This struct's view body
    var body: some View {
        // Show either the app or the log-in screen
        return Group {
            if logInSuccess {
                AllScreens(userID)
            }
            else {
                // Will pass out the associated user's id
                LogInScreen(logInSuccess: $logInSuccess, userID: $userID)
            }
        }
    }
}
