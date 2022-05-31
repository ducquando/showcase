//
//  AppearanceModifier.swift
//  Showcase
//
//  Created by Prasanth on 22/04/2022
//  on https://stackoverflow.com/a/71971172/18760190
//
//  Modified by quannz on 13/05/2022.
//
//

import SwiftUI

/// Program's appearance Mode
enum AppearanceOption: String, Identifiable, CaseIterable, CustomStringConvertible {
    /// System mode
    case system
    /// Light mode
    case light
    /// Dark mode
    case dark
    
    /// This app's id
    var id: AppearanceOption {
        self
    }
    
    /// toString() method
    var description: String {
        rawValue.prefix(1).uppercased() + rawValue.dropFirst()
    }
}

/// Appearance observer class
class AppearanceSet: ObservableObject {
    /// Observe the change of appearance settings
    @AppStorage("appThemeSetting") var appThemeSetting = AppearanceOption.system
}

/// Modify the appearance according to user's choice
struct AppearanceModifier: ViewModifier {
    /// Listen to change of appearance settings
    @ObservedObject var appearance: AppearanceSet = AppearanceSet()

    public func body(content: Content) -> some View {
        content
            .preferredColorScheme((appearance.appThemeSetting == .system) ?
                nil : appearance.appThemeSetting == .light ?
                .light : .dark)
    }
}

