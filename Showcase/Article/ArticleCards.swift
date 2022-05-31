//
//  ArticleCards.swift
//  Showcase
//
//  Created by quannz on 29/05/2022.
//

import SwiftUI

/// Structure represents the article preview card
struct ArticleCards: View {
    /// Width length
    let cardWidth: CardIndexSize
    /// Height length
    let cardHeight: CardIndexSize
    
    /// Individual card layer
    struct Card: View {
        /// This card layer's color
        let color: Color
        /// This card layer's opacity
        let opacity: Double
        /// This card layer's width
        let width: CGFloat?
        /// This card layer's height
        let height: CGFloat?
        
        /// Constructs this preview card given all the attributes (color, opacity, width and height)
        init(_ color: Color, _ opacity: Double, _ width: CGFloat?,
             _ height: CGFloat?) {
            self.color = color
            self.opacity = opacity
            self.width = width
            self.height = height
        }
        
        /// This struct's view bodt
        var body: some View {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(color) // Color
                .opacity(opacity)
                .frame(width: width, height: height, alignment: .topLeading)
        }
    }
    
    /// This struct's view body
    /// Contains of 3 overlay cards
    var body: some View {
        // Third-level card
        Card(Color.ui.documentThird, 0.3, cardWidth.third, cardHeight.third)
        // Second-level card
        Card(Color.ui.documentSecondary, 0.7, cardWidth.secondary, cardHeight.secondary)
        // First-level card
        Card(Color.ui.document, 1, cardWidth.primary, cardHeight.primary)
    }
    
}
