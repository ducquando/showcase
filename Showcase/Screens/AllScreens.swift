//
//  AllScreens.swift
//  Showcase
//
//  Created by quannz on 29/05/2022.
//

import SwiftUI

/// The app's content
/// Containing Home screen, Save screen, Search screen, and Settings screen, nested in a tab view controller
struct AllScreens: View {
    /// The id of the user attempting to use the app
    let userID: String
    /// The search text
    @State var searchQuery = ""
    /// The search result
    @State var searchArticleIDs : [String] = []
    /// The saved articles
    @State var savedArticleIDs : [String] = []
    /// The recommended articles
    @State var recommendedArticleIDs : [String] = []
    
    /// Construct this view using the correct user's id
    init(_ id: String){
        self.userID = id
    }
    
    /// This view's body
    var body: some View {
        // Display all screens in a window to enable the tab view controller
        TabView{
            // Home Screen
            NavigationView{
                HomeScreen(userID, $recommendedArticleIDs)
            }
            .modifier(AppearanceModifier())
            .refreshable {
                /// Recommend 5 new articles every time this view is refreshed
                let algor = RecommendationAlgorithm(userID)
                recommendedArticleIDs = algor.recommendArticle()
            }
            .onAppear {
                /// Recommend 5 new articles when this view is loaded
                let algor = RecommendationAlgorithm(userID)
                recommendedArticleIDs = algor.recommendArticle()
            }
            .tabItem {
                Text("Home")
                Image(systemName: "house")
            }
            
            // Search Screen
            NavigationView{
                SearchScreen(userID, $searchArticleIDs)
            }
            .modifier(AppearanceModifier())
            .searchable(text: $searchQuery, prompt: "Search by title")
            .onSubmit (of: .search) {
                let db = QueryDB()
                searchArticleIDs = db.queryArticlesByTitle(searchQuery)
            }
            .tabItem {
                Text("Search")
                Image(systemName: "magnifyingglass")
            }
            
            // Save Screen
            NavigationView{
                SaveScreen(userID, $savedArticleIDs)
            }
            .modifier(AppearanceModifier())
            .onAppear {
                let db = QueryDB()
                savedArticleIDs = db.querySavedArticles(userID)
            }
            .tabItem {
                Text("Saved")
                Image(systemName: "bookmark")
            }
            
            // Settings Screen
            NavigationView{
                SettingsScreen()
            }
            .modifier(AppearanceModifier())
            .tabItem {
                Text("Settings")
                Image(systemName: "gearshape")
            }
        }
        .accentColor(Color.ui.document)
    }
}
