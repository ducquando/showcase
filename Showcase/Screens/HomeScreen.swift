//
//  SaveScreen.swift
//  Showcase
//
//  Created by quannz on 15/05/2022.
//

import SwiftUI

/// A structure representing the home screen
struct HomeScreen: View {
    /// Saved articles' id
    @Binding var recommendArticles: [String]
    /// This user's id
    var userID: String
    
    /// Construct this struct with modified styling settings
    init(_ user: String, _ results: Binding<[String]>){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = navTitleStyle
        UINavigationBar.appearance().tintColor =  UIColor.white
        self.userID = user
        self._recommendArticles = results
    }
    
    var body: some View {
        ZStack{
            // Background color
            Color.ui.indigoSecondary.ignoresSafeArea()
            Color.ui.indigo
            
            ScrollView (showsIndicators: false) {
                ForEach(recommendArticles, id: \.self) { item in
                    NavigationLink(destination:
                                    ArticleScreen(articleID: item,
                                                  userID: userID)
                    ) {
                        ArticlePreviewLarge(article: Article(id: item),
                                            user: userID)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("For you")
    }
}
