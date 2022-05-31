//
//  SearchScreen.swift
//  Showcase
//
//  Created by quannz on 14/05/2022.
//

import SwiftUI

/// A structure representing the search screen
struct SearchScreen: View {
    /// Searched articles' id
    @Binding var searchedResult: [String]
    /// This user's id
    var userID: String
    
    /// Construct this struct with modified styling settings
    init(_ user: String, _ results: Binding<[String]>){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = UIColor.white
        self.userID = user
        self._searchedResult = results
    }
    
    /// This struct's view body
    var body: some View {
        ZStack{
            // Background color
            Color.ui.indigoSecondary.ignoresSafeArea()
            Color.ui.indigo
            
            // Foreground cards
            // 2-column card stack
            let columns = [GridItem(.flexible()),GridItem(.flexible())]
            ScrollView {
                // Display cards in a lazy VGrid with 2 columns
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(searchedResult, id: \.self) { item in
                        NavigationLink(destination:
                                        ArticleScreen(articleID: item,
                                                      userID: userID)
                        ) {
                            ArticlePreviewSmall(article: Article(id: item),
                                                user: userID)
                        }
                    }
                }
            }
            .padding()
            .frame(alignment: .leading)
        }
        .navigationTitle("Search")
    }
}
