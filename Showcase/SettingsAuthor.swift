//
//  SettingsAuthor.swift
//  Showcase
//
//  Created by quannz on 09/05/2022.
//

import SwiftUI

/// Structure representing the program's author information
struct AuthorContent {
    /// The information regarding this app's authors
    var information : String?
}

/// Structure representing the author's information view
struct SettingsAuthor: View {
    /// The information regarding this app's authors
    var author = AuthorContent(information: "Sed nibh velit diam cras diam donec ut nulla diam, hendrerit ut ornare id ac id ut vestibulum nibh vel, viverra massa velit praesent diam erat sapien eu nec malesuada pellentesque eu integer eget sit curabitur nec tristique tincidunt volutpat condimentum amet ultrices praesent morbi vulputate sem mauris eu, amet malesuada venenatis nec aliquam dignissim at eu sodales erat sed nunc venenatis gravida rhoncus, rutrum lobortis tellus eget pellentesque diam euismod mattis proin quis a ut sit viverra ullamcorper pulvinar enim vestibulum risus aliquet elit tortor, curabitur pretium dictumst faucibus mauris varius vel non tristique diam rutrum at tincidunt id")
    
    /// This structure's view body
    var body: some View {
        ZStack {
            // Background color
            Color.ui.indigoSecondary.ignoresSafeArea()
            Color.ui.document
            
            // Content section
            ScrollView{
                Text("About the authors")
                    .font(Font.custom("SFProRounded-Bold", size: 22))
                    .foregroundColor(Color.ui.textHeading)
                    .padding(.all)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(author.information ?? "")
                    .padding(.horizontal)
                    .lineSpacing(5)
                    .foregroundColor(Color.ui.textBody)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
