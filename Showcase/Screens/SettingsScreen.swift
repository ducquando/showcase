//
//  SettingsScreen.swift
//  Showcase
//
//  Created by quannz on 08/05/2022.
//

import SwiftUI

/// A structure representing the settings screen
struct SettingsScreen: View {
    /// Construct this struct with modified styling settings
    init(){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = navTitleStyle
        UINavigationBar.appearance().tintColor =  UIColor.white
    }
    
    /// Structure representing the content of view section
    struct SectionContent: View {
        /// This section's symbol
        let sectionSymbol: String
        /// This section's name
        let sectionName: String
        
        /// This section's view body
        var body: some View {
            HStack {
                // Displaying symbol
                ZStack{
                    // Background box
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color.ui.textHeading)
                        .frame(width: 40, height: 40)
                    // Symbol
                    Image(systemName: sectionSymbol)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                        .foregroundColor(Color.ui.document)
                }
                
                // Displaying text
                Text(sectionName)
                    .buttonTextStyle()
                    .padding(.horizontal, 5)
            }
        }
    }
    
    /// Structure representing the appearance's view section
    struct AppearanceSection: View {
        /// Listen the change of the program's appearance
        @ObservedObject var viewModel = AppearanceSet()
        
        /// This struct's view body
        var body: some View {
            Section() {
                NavigationLink(destination: AppearanceSettings(selection: $viewModel.appThemeSetting)) {
                    SectionContent(sectionSymbol: "eye.fill",
                                   sectionName: "Appearance")
                }
                .frame(height: 50)     // box's height size is 50
            }
        }
    }
    
    /// Structure representing the author's view section
    struct AuthorSection: View {
        /// This struct's view body
        var body: some View {
            Section() {
                NavigationLink(destination: SettingsAuthor()) {
                    SectionContent(sectionSymbol: "person.2.fill",
                                   sectionName: "About the authors")
                }
                .frame(height: 50)     // box's height size is 50
            }
        }
    }
    
    /// This struct's view body
    var body: some View {
        ZStack() {
            // Background color
            Color.ui.indigoSecondary.ignoresSafeArea()
            Color.ui.indigo
            
            // Foreground content
            VStack {
                Form {
                    // Appearance's section
                    AppearanceSection()
                    
                    // Application author information's section
                    AuthorSection()
                }
            }
            .padding(.top, 10)
        }
        .navigationTitle("Settings")
    }
}
