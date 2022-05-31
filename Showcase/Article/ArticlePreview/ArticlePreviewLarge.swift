//
//  ArticlePreviewLarge.swift
//  Showcase
//
//  Created by quannz on 14/05/2022.
//

import SwiftUI

/// Structure representing an article's full-sized preview
struct ArticlePreviewLarge: View {
    /// The user's id
    let userID: String
    /// The article's id
    let articleID: String
    /// Variables that will be fetched from the database
    let title, author, fieldName, abstract: String
    /// Article's thumbnail
    let previewImage: ArticleThumbnail
    /// The article's size
    let (cardWidth, cardHeight) = getPreviewSize(.large)
    
    /// Construct the article preview with contents
    init(article: Article, user: String) {
        self.userID = user
        self.articleID = article.getID()
        self.title = article.header.getTitle()
        self.author = article.header.getAuthor()
        self.fieldName = article.header.getField()
        self.abstract = article.header.abstract
        self.previewImage = article.thumbnail
    }
    
    /// Structure representing the article's header content
    struct Header: View {
        /// Content
        let title, author, abstract: String
        
        /// This struct's view body
        var body: some View {
            // Title
            Text(title)
                .titleStyle()
                .padding(.horizontal)
                .lineLimit(4)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
            
            // Author
            Text(author)
                .authorStyle()
                .padding(.horizontal)
                .padding(.bottom, 1)
                .multilineTextAlignment(.leading)
            
            // Abstract
            Text(abstract)
                .abstractStyle()
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
        }
    }
    
    /// Structure representing the article's field content and button
    struct FieldAndButton: View {
        /// User's id
        let userID: String
        /// Article's id
        let articleID: String
        /// Article's field name
        let field: String
        /// Condition for showing the adjustment's sheet
        @State private var showingAdjustment = false
        
        /// This struct's view body
        var body: some View {
            HStack{
                // Field
                Text(field)
                    .fieldStyle(field)
                Spacer()
                
                // Functional button
                Button(action:{ showingAdjustment.toggle()}) {
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                }
                .foregroundColor(Color.ui.textHeading)
                .padding(.bottom, 5)
                .sheet(isPresented: $showingAdjustment) {
                    SeeMoreAdjustment(userID, articleID)
                }
            }
            .padding(.bottom, 24)
            .padding(.horizontal)
        }
    }
    
    /// This struct's body view containing various text's content
    var body: some View {
        ZStack{
            // Background cards
            ArticleCards(cardWidth: cardWidth, cardHeight: cardHeight)
            
            // Foreground body
            VStack {
                // Article's thumbnail
                previewImage
                    .frame(height: cardHeight.primary * 2/3, alignment: .center)
                    .clipped()
                
                // Article's header content
                HStack{
                    VStack(alignment: .leading){
                        // Top: article's header contents
                        Header(title: title, author: author, abstract: abstract)
                        
                        Spacer()
                        
                        // Bottom: field and functional button
                        FieldAndButton(userID: userID, articleID: articleID,
                                       field: fieldName)
                    }
                    Spacer()
                }
            }
        }
        .frame(width: cardWidth.primary, height: cardHeight.third, alignment: .top)
        .cornerRadius(10)
    }
}
