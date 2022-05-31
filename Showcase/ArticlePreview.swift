//
//  ArticlePreview.swift
//  Showcase
//
//  Created by quannz on 27/05/2022.
//

import SwiftUI

class ArticlePreview: View {
    let title, author, articleID, imageURL: String
    let (cardWidth, cardHeight) = getPreviewSize(.mid)
    
    init(infoDict: [String : String]) {
        self.articleID = String(infoDict["ID"]!)
        self.title = infoDict["Title"]!
        self.author = infoDict["Author"]!
        self.imageURL = infoDict["ImageURL"]!
    }
    
    var body: some View {
        ZStack(alignment: .top){
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.ui.documentThird)
                .opacity(0.3)
                .frame(width: cardWidth.third, height: cardHeight.third, alignment: .topLeading)
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.ui.documentSecondary)
                .opacity(0.7)
                .frame(width: cardWidth.secondary, height: cardHeight.secondary, alignment: .topLeading)
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.ui.document)
                .frame(width: cardWidth.primary, height: cardHeight.primary, alignment: .topLeading)
            
            VStack {
                ArticleThumbnail()
                    .frame(height: cardHeight.primary * 2/3, alignment: .center)
                    .clipped()
                HStack{
                    VStack(alignment: .leading){
                        Text(title)
                            .smallTitleStyle()
                            .padding(.horizontal)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(author)
                            .smallAuthorStyle()
                            .padding(.horizontal)
                        Spacer()
                    }
                    Spacer()
                }
            }
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        print("Save article")
                    }) {
                        Image(systemName: "bookmark")
                            .font(.title2)
                    }
                    
                }
                .foregroundColor(Color.ui.textHeading)
                .padding(.bottom, 20)
                .padding(.horizontal)
            }
        }
        .frame(width: cardWidth.primary, height: cardHeight.third, alignment: .topLeading)
        .cornerRadius(10)
    }
}

