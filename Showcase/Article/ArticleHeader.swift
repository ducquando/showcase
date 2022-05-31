//
//  ArticleHeader.swift
//  Showcase
//
//  Created by quannz on 29/05/2022.
//

import SwiftUI

/// Structure representing an article's header
/// Contains of the article's title, author, field name, and abstract fetched from the database
struct ArticleHeader : View {
    /// Variables that will be fetched from the database
    let title, author, field, abstract : String
    
    /// Construct this structure using a dictionary that contains all information of this article
    init(infoDict: [String : String]) {
        title = infoDict["Title"]!
        author = infoDict["Author"]!
        field = infoDict["FieldName"]!
        abstract = infoDict["Abstract"]!
    }
    
    /// This struct's body view containing various text's content
    var body: some View {
        VStack (alignment: .leading) {
            // Tag
            Text(field)
                .fieldStyle(field)
                .padding(.horizontal)
            
            // Title
            Text(title)
                .titleStyle()
                .padding(.horizontal)
                .padding(.bottom, 1)
                .fixedSize(horizontal: false, vertical: true)
            
            // Abstract
            Text(abstract)
                .abstractStyle()
                .padding(.horizontal)
                .padding(.bottom, 1)
                .lineSpacing(3)
            
            // Author
            Text(author)
                .authorStyle()
                .padding(.horizontal)
        }
    }
    
    /// Get this article's title
    func getTitle() -> String {
        return self.title
    }
    /// Get this article's author
    func getAuthor() -> String {
        return self.author
    }
    /// Get this article's field name
    func getField() -> String {
        return self.field
    }
    /// Get this article's abstract content
    func getAbstract() -> String {
        return self.abstract
    }
}
