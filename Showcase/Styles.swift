//
//  Styles.swift
//  Showcase
//
//  Created by quannz on 15/05/2022.
//

import SwiftUI

/// Styling for article's title text (default version)
struct ArticleTitleStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 26))
            .foregroundColor(Color.ui.textHeading)
    }
}

/// Styling for article's title text (small version)
struct ArticleTitleSmallStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 16))
            .foregroundColor(Color.ui.textHeading)
    }
}

/// Styling for article's heading text
struct ArticleHeadingStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 22))
            .foregroundColor(Color.ui.textHeading)
    }
}

/// Styling for article's author text
struct ArticleAuthorStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 15))
            .foregroundColor(Color.ui.textHeading)
    }
}

/// Styling for article's author text (small version)
struct ArticleAuthorSmallStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 12))
            .foregroundColor(Color.ui.textHeading)
    }
}

/// Styling for article's body text
struct ArticleContentStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineSpacing(5)
            .foregroundColor(Color.ui.textBody)
    }
}

/// Styling for article's abstract text
struct ArticleAbstractStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("", size: 13))
            .foregroundColor(Color.ui.textBody)
    }
}

/// Styling for the option button
struct OptionStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Semibold", size: 16))
            .foregroundColor(Color.ui.textHeading)
    }
}

/// Styling for the option button (small version)
struct OptionSmallStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Regular", size: 12))
            .foregroundColor(Color.ui.textBody)
    }
}

/// Styling for the flag button
struct ArticleFlagStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineSpacing(5)
            .foregroundColor(Color.ui.textBody)
            .cornerRadius(8)
            .padding()
    }
}

/// Styling for article's field box (default version)
struct FieldStyle : ViewModifier {
    /// The spacing in-between characters
    let fontSpace = 6
    /// The inputed field name
    let fieldName: String
    /// This frame's size
    let fieldFrameSize: CGFloat
    
    /// Construct this struct with the input field name's string
    init(_ input: String){
        self.fieldName = input
        // The frame size is set to 20 + number of character * character space
        self.fieldFrameSize = CGFloat(input.count * self.fontSpace + 20)
    }
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 12))
            .frame(width: fieldFrameSize, height: 18, alignment: .center)
            .foregroundColor(Color.ui.textHeading)
            .background(RoundedRectangle(cornerRadius: 8).stroke().foregroundColor(Color.ui.textHeading))
    }
}

/// Styling for article's field box (small version)
struct FieldSmallStyle : ViewModifier {
    /// The spacing in-between characters
    let fontSpace = 4
    /// The inputed field name
    let fieldName: String
    /// This frame's size
    let fieldFrameSize : CGFloat
    
    /// Construct this struct with the input field name's string
    init(_ input: String){
        self.fieldName = input
        // The frame size is set to 10 + number of character * character space
        self.fieldFrameSize = CGFloat(input.count * self.fontSpace + 10)
    }
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 8))
            .frame(width: fieldFrameSize, height: 12, alignment: .center)
            .foregroundColor(Color.ui.textHeading)
            .background(RoundedRectangle(cornerRadius: 8).stroke().foregroundColor(Color.ui.textHeading))
    }
}

/// Styling for the navigation title style
let navTitleStyle: [NSAttributedString.Key : Any] =
    [.foregroundColor: UIColor(Color.ui.textSection),
     .font: UIFont(name: "SFProRounded-Bold", size: 32)!]

/// Styling for the in-line back text style
let navBackStyle: [NSAttributedString.Key : Any] =
    [.foregroundColor: UIColor(Color.ui.textSection),
    .font: UIFont(name: "SFProRounded-Bold", size: 18)!]

/// Styling for article's button text
struct ButtonSettingsStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Semibold", size: 17))
            .foregroundColor(Color.ui.textHeading)
    }
}

/// Styling for the primary-choice button box
struct ButtonPrimaryStyle: ViewModifier {
    /// The spacing in-between characters
    let fontSpace = 10
    /// The inputed choice
    let choice: String
    /// This frame's size
    let frameSize : CGFloat
    
    /// Construct this struct with the input choice string
    init(_ input: String){
        self.choice = input
        // The frame size is set to 50 + number of character * character space
        self.frameSize = CGFloat(input.count * self.fontSpace + 50)
    }
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 18))
            .foregroundColor(Color.ui.document)
            .frame(width: frameSize, height: 35, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color.ui.button))
    }
}

/// Styling for the secondary-choice button box
struct ButtonSecondaryStyle: ViewModifier {
    /// The spacing in-between characters
    let fontSpace = 10
    /// The inputed choice
    let choice: String
    /// This frame's size
    let frameSize : CGFloat
    
    /// Construct this struct with the input choice string
    init(_ input: String){
        self.choice = input
        // The frame size is set to 25 + number of character * character space
        self.frameSize = CGFloat(input.count * self.fontSpace + 25)
    }
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 18))
            .foregroundColor(Color.ui.textHeading)
            .frame(width: frameSize, height: 35, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 16).stroke().foregroundColor(Color.ui.textHeading))
    }
}

/// Styling for textbox in the log-in screen
struct LogInTextBoxStyle: ViewModifier{
    /// The textbox's width
    let fieldFrameWidth: CGFloat = UIScreen.main.bounds.width - 40.0
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Regular", size: 18))
            .frame(width: fieldFrameWidth, height: 40, alignment: .center)
            .foregroundColor(Color.ui.textBody)
            .background(RoundedRectangle(cornerRadius: 16).stroke().foregroundColor(Color.ui.textHeading))
    }
}

/// Styling for button in the log-in screen
struct LogInButtonStyle: ViewModifier{
    /// The textbox's width
    let fieldFrameWidth: CGFloat = UIScreen.main.bounds.width - 40.0
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Semibold", size: 18))
            .frame(width: fieldFrameWidth, height: 40, alignment: .center)
            .foregroundColor(Color.ui.textSection)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.ui.indigo))
    }
}

/// Styling for logo in the log-in screen
struct LogInLogoStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SFProRounded-Bold", size: 30))
            .foregroundColor(Color.ui.textHeading)
    }
}


/// Custom color palette for this program
extension Color {
    /// User interface's colors
    static let ui = Color.UI()
    /// Set use rinterface's colors
    struct UI {
        // System
        /// Program's primary color
        let indigo = Color("indigo")
        /// Program's primary color (darker version)
        let indigoSecondary = Color("indigoSecondary")
        
        // Text background
        /// Program's document background color
        let document = Color("document")
        /// Program's document second-layer overlay color
        let documentSecondary = Color("documentSecondary")
        /// Program's document third-layer overlay color
        let documentThird = Color("documentThird")
        
        // Text
        /// Heading text color
        let textHeading = Color("textHeading")
        /// Body text color
        let textBody = Color("textBody")
        /// Section text color
        let textSection = Color.white
        /// Button text color
        let button = Color("textButton")
    }
}

extension View {
    /// Modify a view to have the styling for article's title text
    func titleStyle() -> some View {
        modifier(ArticleTitleStyle())
    }
    /// Modify a view to have the styling for article's author text
    func authorStyle() -> some View {
        modifier(ArticleAuthorStyle())
    }
    /// Modify a view to have the styling for article's heading text
    func headingStyle() -> some View {
        modifier(ArticleHeadingStyle())
    }
    /// Modify a view to have the styling for article's body text
    func contentStyle() -> some View {
        modifier(ArticleContentStyle())
    }
    /// Modify a view to have the styling for article's abstract text
    func abstractStyle() -> some View {
        modifier(ArticleAbstractStyle())
    }
    /// Modify a view to have the styling for article's field text
    func fieldStyle(_ text: String) -> some View {
        modifier(FieldStyle(text))
    }
    /// Modify a view to have the styling for article's button text
    func buttonTextStyle() -> some View {
        modifier(ButtonSettingsStyle())
    }
    /// Modify a view to have the styling for log-in button
    func buttonLogInStyle() -> some View {
        modifier(LogInButtonStyle())
    }
    /// Modify a view to have the styling for the primary-choice button box
    func primaryButtonStyle(_ text: String) -> some View {
        modifier(ButtonPrimaryStyle(text))
    }
    /// Modify a view to have the styling for the secondary-choice button box
    func secondaryButtonStyle(_ text: String) -> some View {
        modifier(ButtonSecondaryStyle(text))
    }
    /// Modify a view to have the styling for the option button
    func optionButtonStyle() -> some View {
        modifier(OptionStyle())
    }
    /// Modify a view to have the styling for the flag button
    func flagTextStyle() -> some View {
        modifier(ArticleFlagStyle())
    }
    /// Modify a view to have the styling for log-in's textbox
    func textBoxLogInStyle() -> some View {
        modifier(LogInTextBoxStyle())
    }
    /// Modify a view to have the styling for logo
    func logoStyle() -> some View {
        modifier(LogInLogoStyle())
    }
    
    
    // Small version
    /// Modify a view to have the styling for article title text (small version)
    func smallTitleStyle() -> some View {
        modifier(ArticleTitleSmallStyle())
    }
    /// Modify a view to have the styling for article author text (small version)
    func smallAuthorStyle() -> some View {
        modifier(ArticleAuthorSmallStyle())
    }
    /// Modify a view to have the styling for article field text (small version)
    func smallFieldStyle(_ text: String) -> some View {
        modifier(FieldSmallStyle(text))
    }
    /// Modify a view to have the styling for option button (small version)
    func smallOptionButtonStyle() -> some View {
        modifier(OptionSmallStyle())
    }
}
