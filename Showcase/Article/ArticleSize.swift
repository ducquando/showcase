//
//  ArticleSize.swift
//  Showcase
//
//  Created by quannz on 16/05/2022.
//

import SwiftUI

/// Article preview's usages
enum ArticlePreviewCase {
    /// Small card size used for search screen
    case small
    /// Medium card size used for saved screen
    case mid
    /// Large card size used for home screen
    case large
}

/// Article preview tab's size
struct CardIndexSize {
    /// First-level card. Have biggest width size
    let primary: CGFloat
    /// Second-level card. Have smaller width size
    let secondary: CGFloat
    /// Third-level card. Have smallest width size
    let third: CGFloat
}

/// Returns respectively the preview card's width and height struct, given an article's usage case
func getPreviewSize(_ ver: ArticlePreviewCase) -> (CardIndexSize, CardIndexSize) {
    /// This device's screen width size minus the default safe space (40.0)
    let screenWidth: CGFloat = UIScreen.main.bounds.width - 40.0
    /// This card's width
    var cardWidth: CGFloat
    /// This card's height
    var cardHeight: CGFloat
    /// Default height/width ratio
    let heigthOverWidth = 1.8
    
    /// Determine this card's width and height accroding to the given usage case
    switch ver {
    case .large:
        cardWidth = screenWidth
        cardHeight = screenWidth * heigthOverWidth
    case .mid:
        // Medium case has both card's width size and height size two times
        // smaller than that of large case
        cardWidth = screenWidth / 2
        cardHeight = screenWidth * heigthOverWidth / 2
    case .small:
        // Small case has card's height size two times smaller than that of
        // medium case
        cardWidth = screenWidth / 2
        cardHeight = screenWidth * heigthOverWidth / 4
    }
    
    /// Preview card's width struct
    let cardWidthStruct = CardIndexSize(primary: cardWidth,
                                        secondary: cardWidth - cardWidth * 0.04,
                                        third: cardWidth - cardWidth * 0.08)
    /// Preview card's height struct
    let cardHeightStruct = CardIndexSize(primary: cardHeight,
                                        secondary: cardHeight + cardHeight * 0.015,
                                        third: cardHeight + cardHeight * 0.03)
    
    return (cardWidthStruct, cardHeightStruct)
}
