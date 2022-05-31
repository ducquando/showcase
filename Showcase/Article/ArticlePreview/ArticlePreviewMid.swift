//
//  ArticlePreviewMid.swift
//  Showcase
//
//  Created by quannz on 14/05/2022.
//

import SwiftUI

/// Structure representing an article's mid-sized preview
struct ArticlePreviewMid: View {
    /// The user's id
    let userID: String
    /// The article's id
    let articleID: String
    /// Variables that will be fetched from the database
    let title, author: String
    /// Article's thumbnail
    let previewImage: ArticleThumbnail
    /// The article's size
    let (cardWidth, cardHeight) = getPreviewSize(.mid)
    /// The save symbol
    @State var saveSymbol = "bookmark.fill"
    
    /// Construct the article preview with contents
    init(article: Article, user: String) {
        self.userID = user
        self.articleID = article.getID()
        self.title = article.header.getTitle()
        self.author = article.header.getAuthor()
        self.previewImage = article.thumbnail
    }
    
    /// Structure representing the functional button
    struct FunctionalButton: View {
        /// User's id
        let userID: String
        /// Article's id
        let articleID: String
        /// The save symbol
        @Binding var saveSymbol: String
        
        /// This struct's view body
        var body: some View {
            VStack{
                Spacer()     // right-aligned
                HStack {
                    Spacer()
                    Image(systemName: saveSymbol)
                        .font(.title2)
                        .onTapGesture {
                            let db = DeleteFromDB()
                            db.deleteSaveArticle(userID, articleID)
                            saveSymbol = "bookmark"
                        }
                }
                .foregroundColor(Color.ui.textHeading)
                .padding(.bottom, 20)
                .padding(.horizontal)
            }
        }
    }
    
    /// Structure representing the article's header content
    struct Header: View {
        /// Content
        let title, author: String
        
        /// This struct's view body
        var body: some View {
            HStack{
                VStack(alignment: .leading){
                    // Title
                    Text(title)
                        .smallTitleStyle()
                        .padding(.horizontal)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                    // Author
                    Text(author)
                        .smallAuthorStyle()
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    /// This struct's body view containing various text's content
    var body: some View {
        ZStack(alignment: .top){    // top-aligned
            // Background cards
            ArticleCards(cardWidth: cardWidth, cardHeight: cardHeight)
            
            // Foreground body
            VStack {
                previewImage
                    // The image will be clipped into a frame having a height
                    // equals 2/3 the card's height
                    .frame(height: cardHeight.primary * 2/3, alignment: .center)
                    .clipped()
                
                // Article's header content
                Header(title: title, author: author)
            }
            
            // Functional button
            FunctionalButton(userID: userID, articleID: articleID, saveSymbol: $saveSymbol)
        }
        .frame(width: cardWidth.primary, height: cardHeight.third,
               alignment: .topLeading)
        .cornerRadius(10)
    }
}
