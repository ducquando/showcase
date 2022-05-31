//
//  Done.swift
//  Showcase
//
//  Created by quannz on 16/05/2022.
//

import SwiftUI

/// Pop-up message implications
enum DoneVersion {
    /// When an article is succesfully flagged
    case flag
    /// When an article is succesfully rated as inappropriate
    case inap
    /// When an article is succesfully saved
    case save
}

/// Show the pop-up message view
struct Done: View {
    /// The showing content
    let text: String
    
    /// Construct this view with the input pop-up message implication
    init(_ ver: DoneVersion){
        switch ver {
        case .flag:
            text = "Submitted"
        case .inap:
            text = "Done"
        case .save:
            text = "Saved"
        }
    }
    
    /// This struct's view body
    var body: some View {
        VStack{
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            Text(text)
                .padding(.top, 5)
                .font(Font.custom("SFProRounded-Semibold", size: 16))
        }
            .frame(width: 140, height: 140, alignment: .center)
            .background(Color.ui.document)
            .foregroundColor(Color.ui.button)
            .cornerRadius(30)
    }
}
