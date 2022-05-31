//
//  ArticlePreviewSmall.swift
//  Showcase
//
//  Created by quannz on 14/05/2022.
//

import SwiftUI

/// Structure representing an article's small-sized preview
struct ArticlePreviewSmall: View {
    /// The user's id
    let userID: String
    /// The article's id
    let articleID: String
    /// Variables that will be fetched from the database
    let title, author, fieldName: String
    /// The article's size
    let (cardWidth, cardHeight) = getPreviewSize(.small)
    
    /// Construct the article preview with contents
    init(article: Article, user: String) {
        self.userID = user
        self.articleID = article.getID()
        self.title = article.header.getTitle()
        self.author = article.header.getAuthor()
        self.fieldName = article.header.getField()
    }
    
    /// Structure representing the article's header content
    struct Header: View {
        /// Content
        let title, author: String
        
        /// This struct's view body
        var body: some View {
            HStack{     // left-aligned
                VStack(alignment: .leading){
                    // Title
                    Text(title)
                        .smallTitleStyle()
                        .padding([.horizontal, .top])
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
    
    /// Structure representing the article's field content and button
    struct FieldAndButton: View {
        /// User's id
        let userID: String
        /// Article's field name
        let field: String
        
        /// This struct's view body
        var body: some View {
            VStack{
                Spacer()        // right-aligned
                HStack{
                    // Field
                    Text(field)
                        .smallFieldStyle(field)
                    Spacer()
                    
                    // Save button
                    Image(systemName: "bookmark")
                        .font(.title2)
                        .foregroundColor(Color.ui.textHeading)
                        .onTapGesture {
                            print("Saved")
                        }
                        .padding(.bottom, 5)
                }
                .padding(.bottom, 10)
                .padding(.horizontal)
            }
        }
    }
    
    /// This struct's body view containing various text's content
    var body: some View {
        ZStack(alignment: .top){      // top-aligned
            // Background cards
            ArticleCards(cardWidth: cardWidth, cardHeight: cardHeight)
            
            // Article's header content
            Header(title: title, author: author)
                .frame(alignment: .topLeading)
            
            // Field and save button
            FieldAndButton(userID: userID, field: fieldName)
        }
        .frame(width: cardWidth.primary, height: cardHeight.third, alignment: .topLeading)
        .cornerRadius(10)
    }
}
