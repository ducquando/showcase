//
//  SettingsAppearance.swift
//  Showcase
//
//  Created by Majid on 19/06/2019
//  on https://swiftwithmajid.com/2019/06/19/building-forms-with-swiftui/
//
//  Modified by quannz on 13/05/2022.
//

import SwiftUI

/// The appearance settings view
struct AppearanceSettings: View {
    /// Programmatically selected appearance
    @Binding var selection: AppearanceOption
    
    /// This view's body
    var body: some View {
        ZStack() {
            // Background color
            Color.ui.indigoSecondary.ignoresSafeArea()
            Color.ui.indigo
            
            // Selected settings for program's appearance mode
            VStack {
                Form {
                    Section(header: Text("Appearance")
                            .foregroundColor(Color.ui.textSection),
                            footer: Text("System refers to your device's appearance setting.")
                            .foregroundColor(Color.ui.textSection)){
                        // Display all possible options
                        ForEach(0 ..< AppearanceOption.allCases.count, id: \.self) {
                            index in
                            HStack {
                                // Button's symbol and text
                                Button(action: {
                                    self.selection = AppearanceOption.allCases[index]
                                }){
                                    Text(AppearanceOption.allCases[index].description)
                                    .foregroundColor(Color.ui.textHeading)
                                }
                                Spacer()
                                // Display checkmark on the right if selected
                                if (self.selection == AppearanceOption.allCases[index]){
                                    Image(systemName: "checkmark")
                                    .foregroundColor(Color.ui.textHeading)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
