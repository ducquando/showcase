//
//  SaveScreen.swift
//  Showcase
//
//  Created by quannz on 15/05/2022.
//

import SwiftUI

/// A structure representing the save screen
struct SaveScreen: View {
    /// Saved articles' id
    @Binding var savedArticles: [String]
    /// This user's id
    var userID: String
    
    /// Construct this struct with modified styling settings
    init(_ user: String, _ results: Binding<[String]>){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = navTitleStyle
        UINavigationBar.appearance().tintColor =  UIColor.white
        self.userID = user
        self._savedArticles = results
    }
    
    var body: some View {
        ZStack{
            // Background color
            Color.ui.indigoSecondary.ignoresSafeArea()
            Color.ui.indigo
            
            // Foreground cards
            // 2-column card stack
            let columns = [GridItem(.flexible()),GridItem(.flexible())]
            ScrollView (showsIndicators: false) {
                // Display cards in a lazy VGrid with 2 columns
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(savedArticles, id: \.self) { item in
                        NavigationLink(destination:
                                        ArticleScreen(articleID: item,
                                                      userID: userID)
                        ) {
                            ArticlePreviewMid(article: Article(id: item),
                                                user: userID)
                        }
                    }
                }
            }
            .padding()
            .frame(alignment: .leading)
        }
        .navigationTitle("Saved")
    }
}
