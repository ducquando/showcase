//
//  ArticleBody.swift
//  Showcase
//
//  Created by quannz on 29/05/2022.
//

import SwiftUI

/// Structure representing an article's body
/// Contains of introduction, methodology, findings, and discussion content fetched from the database
struct ArticleBody: View {
    /// Variables that will be fetched fronm the database
    let introContent, methodContent, findingsContent, discussContent,
        conclusionContent : String?
    /// The screen's width maximum value
    let maxWidth = UIScreen.main.bounds.width
    
    /// Construct this structure using a dictionary that contains all information of this article
    init(infoDict: [String : String]) {
        introContent = infoDict["Introduction"]
        methodContent = infoDict["Methodology"]
        findingsContent = infoDict["Findings"]
        discussContent = infoDict["Discussion"]
        conclusionContent = infoDict["Conclusion"]
    }
    
    /// Structure representing the content of an article
    struct BodyContent: View {
        /// An article's heading string
        let heading: String
        /// All the body string
        /// A nil value indicating the article does not have this struct
        let content: String?
        
        /// This struct's view body
        var body: some View {
            // Only display if there is content
            if (content != nil && content != "") {
                Group {
                    // Heading
                    Text(heading)
                        .headingStyle()
                        .padding(.all)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Content
                    Text(content!)
                        .padding(.horizontal)
                        .contentStyle()
                        .padding(.bottom)
                }
            }
        }
    }
    
    /// This struct's body view containing various text's content
    var body : some View {
        // Introduction section
        BodyContent(heading: "Introduction", content: introContent)
        
        // Methodology section
        BodyContent(heading: "Methodology", content: methodContent)
        
        // Findings section
        BodyContent(heading: "Findings", content: findingsContent)
        
        // Discussion section
        BodyContent(heading: "Discussion", content: discussContent)
        
        // Conclusion section
        BodyContent(heading: "Conclusion", content: conclusionContent)
    }
    
}

