//
//  ContentView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/23/24.
//

import SwiftUI


struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                OnboardingMainView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview("English") {
    ContentView()
}
#Preview("Russian") {
    ContentView().environment(\.locale, Locale(identifier: "RU"))
}
#Preview("Spanish") {
    ContentView().environment(\.locale, Locale(identifier: "ES"))
}
