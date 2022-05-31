//
//  Flag.swift
//  Showcase
//
//  Created by quannz on 16/05/2022.
//

import SwiftUI

/// Flagging input messgae text box view
struct TextEditingView: View {
    /// On-changing inputed text
    @State var fullText: String = "Please explain why you are concerned about this article..."
    
    /// This struct's view body
    var body: some View {
        TextEditor(text: $fullText)
            .flagTextStyle()
    }
}

/// Flagging view
struct FlagAdjustment: View {
    /// Tracking the inputed info
    let userID, articleID, fieldName: String
    /// Variable to trigger the dismiss function
    @Environment(\.dismiss) var dismiss
    /// Condition for showing the notification
    @State var confirmationOpacity = 0.0
    @State var confirmationVer : DoneVersion = .flag
    
    /// This struct's view body
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                // Title
                Text("Report")
                    .titleStyle()
                
                // Text-box
                TextEditingView()
                    .background(RoundedRectangle(cornerRadius: 8).stroke().foregroundColor(Color.ui.textHeading))
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                // Functional buttons
                HStack{
                    Spacer()
                    Button (action: { dismiss() }){
                        Text("Cancel")
                            .secondaryButtonStyle("Cancel")
                    }
                    Text("Submit")
                        .primaryButtonStyle("Submit")
                        .onTapGesture {
                            let db = UpdateDB()
                            var point = -2.0
                            // Check whether the user input any flagging detail
                            if TextEditingView().fullText != "Please explain why you are concerned about this article..." {
                                point = -3.0
                            }
                            // Update the point
                            db.updateArticlePoint(userID, articleID, point)
                            
                            // Popup the confirmation status
                            confirmationVer = .flag
                            confirmationOpacity = 100.0
                            
                            // Close the sheet after 0.3 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                dismiss()
                            }
                        }
                }
                .padding(.top)
            }
            .padding()
            
            Done(confirmationVer)
                .opacity(confirmationOpacity)
        }
    }
}
