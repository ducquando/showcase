//
//  ContentView.swift
//  Showcase
//
//  Created by quannz on 04/05/2022.
//

import SwiftUI

/// A structure representing the article reading screen
struct ArticleScreen: View {
    var articleID, userID: String
    
    /// Condition for showing the adjustment's sheet
    @State private var showingAdjustment = false;
    
    /// the reading screen's view body
    var body: some View {
        ZStack (alignment: .topLeading) {
            // Background colors
            Color.ui.indigoSecondary.ignoresSafeArea()
            Color.ui.document
            
            let article = Article(id: articleID)
            
            ScrollView {
                // Header
                article.header
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Thumbnail
                let maxWidth = UIScreen.main.bounds.width
                article.thumbnail
                    .frame(width: maxWidth, height: maxWidth/3, alignment: .center)
                    .clipped()

                // Body
                article.body
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding(.vertical)
            // Display a functional button in the naviagtion bar
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action:{ showingAdjustment.toggle() } ) {
                        Image(systemName: "ellipsis.circle")
                            .font(.title3)
                            .foregroundColor(Color.ui.textSection)
                    }
                    .foregroundColor(Color.ui.textHeading)
                    .padding(.bottom, 5)
                    .sheet(isPresented: $showingAdjustment) {
                        SeeMoreAdjustment(userID, articleID)
                    }
                }
            }
        }
    }
}
