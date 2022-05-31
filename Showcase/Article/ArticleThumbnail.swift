//
//  ArticleThumbnail.swift
//  Showcase
//
//  Created by quannz on 29/05/2022.
//

import SwiftUI

/// Structure representing an article's thumnail
/// Contains of the image's url fetched from the database
struct ArticleThumbnail : View {
    /// The link to the photo
    let imageURL : String
    
    /// Construct this structure using a dictionary that contains all information of this article
    init(infoDict: [String : String]) {
        imageURL = infoDict["ImageURL"]!
    }
    
    /// This struct's body view containing a async image
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            Color.ui.indigo
        }
    }
    
    /// Get the image's link
    func getURL() -> String {
        return imageURL
    }
}
