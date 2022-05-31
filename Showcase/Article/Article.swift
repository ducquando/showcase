//
//  Article.swift
//  Showcase
//
//  Created by quannz on 08/05/2022.
//

import SwiftUI

/// Structure representing the whole article.
/// Contains of id, ArticleHeader(), ArticleThumbnail(), and ArticleBody()
struct Article {
    /// The article's id
    let id: String
    /// This article's header structure, fetched using article's id
    let header: ArticleHeader
    /// This article's thumbnail structure, fetched using article's id
    let thumbnail: ArticleThumbnail
    /// This article's body structure, fetched using article's id
    let body: ArticleBody
    
    /// Construct this structure using the input id.
    /// The id will be used to fetch other's attributes from the database.
    init(id: String) {
        self.id = id
        
        // Fetch data from the database, then assign to the attributes
        let db = QueryDB()
        let info = db.queryArticle(articleID: id)
        
        self.header = ArticleHeader(infoDict: info)
        self.thumbnail = ArticleThumbnail(infoDict: info)
        self.body = ArticleBody(infoDict: info)
    }

    /// Returns this Article's id
    func getID() -> String {
        return String(id)
    }
}
