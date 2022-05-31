//
//  MoreOptions.swift
//  Showcase
//
//  Created by quannz on 15/05/2022.
//

import SwiftUI

/// Returns the view of all possible user interactions of an article
struct SeeMoreAdjustment: View {
    /// Variables that are kept track to update the database
    let userID, fieldName, articleID : String
    /// Variable to trigger the dismiss function
    @Environment(\.dismiss) var dismiss
    /// Condition on opeing the flag sheet
    @State private var showingFlagAdjustment = false
    /// Condition for showing the notification
    @State var confirmationOpacity = 0.0
    @State var confirmationVer : DoneVersion = .flag
    
    /// Construct this struct with the article's id
    init(_ user: String, _ article: String) {
        UITableView.appearance().separatorColor = .clear
        let db = QueryDB()
        userID = user
        articleID = article
        fieldName = db.queryFieldNameByArticle(articleID)
    }
    
    /// Structure representing primary button's view
    struct PrimaryButton: View {
        /// Button's content
        let text, description, symbol: String
        
        /// This struct's view body
        var body: some View {
            HStack {
                // Symbol
                Image(systemName: symbol)
                    .font(.title2)
                    .foregroundColor(Color.ui.textHeading)
                    .frame(width: 40, alignment: .center)
                // Heading and sub-heading button text
                VStack(alignment: .leading){
                    Text(text)
                        .optionButtonStyle()
                    Text(description)
                        .smallOptionButtonStyle()
                }
            }
        }
    }
    
    /// Structure representing secondary button's view
    struct SecondaryButton: View {
        /// Button's content
        let text, symbol: String
        
        /// This struct's view body
        var body: some View {
            HStack {
                // Symbol
                Image(systemName: symbol)
                    .font(.title2)
                    .foregroundColor(Color.ui.textBody)
                    .frame(width: 40, alignment: .center)
                // Heading and sub-heading button text
                VStack(alignment: .leading){
                    Text(text)
                        .font(Font.custom("SFProRounded-Semibold", size: 16))
                        .foregroundColor(Color.ui.textBody)
                }
            }
        }
    }
    
    /// This struct's body view
    var body: some View {
        ZStack{
            // The background color
            Color.ui.indigoSecondary.ignoresSafeArea()
            Color.ui.indigo
            
            // All options, represented in terms of a form
            Form {
                Section {
                    // Save button
                    Button (action: {
                        /// The updation database
                        let db = UpdateDB()
                        /// The insertion database
                        let newDb = InsertToDB()
                        
                        // Update the database according to the action
                        // art's point + 1, field's point + 0.1, add save
                        db.increaseArticleAndFieldPoint(userID, articleID,
                                                        fieldName)
                        newDb.insertSaveArticle(userID, articleID)
                        
                        // Popup the confirmation status
                        confirmationVer = .save
                        confirmationOpacity = 100.0
                        
                        // Close the sheet after 0.3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            dismiss()
                        }
                    })
                    {
                        PrimaryButton(text: "Save",
                                      description: "Add this to your saved list.",
                                      symbol: "bookmark.fill")
                    }
                    
                    // Not interested button
                    Button (action: {
                        let db = UpdateDB()
                        db.updateArticlePoint(userID, articleID, -1)
                        db.updateFieldPoint(userID, fieldName, false)
                        
                        // Popup the confirmation status
                        confirmationVer = .inap
                        confirmationOpacity = 100.0
                        
                        // Close the sheet after 0.3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            dismiss()
                        }
                    })
                    {
                        PrimaryButton(text: "Not interested",
                                      description: "See fewer articles like this.",
                                      symbol: "hand.thumbsdown.fill")
                    }
                    
                    
                    // Report button -> open anther report sheet when clicked
                    Button (action: { showingFlagAdjustment.toggle() }) {
                        PrimaryButton(text: "Report",
                                      description: "I'm concerned about this article.",
                                      symbol: "exclamationmark.circle.fill")
                    }
                    .sheet(isPresented: $showingFlagAdjustment) {
                        FlagAdjustment(userID: userID, articleID: articleID,
                                       fieldName: fieldName)
                    }
                }
                
                Section {
                    // Cancel button -> cancel action and hide sheet
                    SecondaryButton(text: "Cancel", symbol: "xmark")
                        .onTapGesture { dismiss() }
                }
            }
            
            Done(confirmationVer)
                .opacity(confirmationOpacity)
        }
    }
}
