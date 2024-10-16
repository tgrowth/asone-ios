//
//  OpenningScreens.swift
//  asone
//
//  Created by Syma on 10/10/24.
//


import SwiftUI

struct OpenningScreensStep {
let image: String
let text: String
}

private let openningSteps = [
OpenningScreensStep(image: "openning",  text: "Track your cycle, mood, and activities in one place."),
OpenningScreensStep(image: "openning",  text: "Get personalized tips for better communication with your partner."),
OpenningScreensStep(image: "openning",  text: "Learn how hormonal changes affect your relationship day-by-day."),
OpenningScreensStep(image: "openning",  text: "Improve your relationship with data-driven insights and advice")
]

struct OpenningScreensView: View {
    @State private var currentStep = 0
    init() {
        UIScrollView.appearance().bounces = false
    }

    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    if self.currentStep == openningSteps.count {
                        self.currentStep += 1
                    } else {
                        self.currentStep -= 1
                    }
                }) {
                    Text(currentStep == 0 ? "AsOne": "Back")
                            .padding(16)
                            .foregroundColor(.black)
                        .padding(.vertical, 7)
                }

                Spacer()
                Button (action: {
                    self.currentStep = openningSteps.count - 1
                }){
                    Text("Skip")
                            .padding(16)
                            .foregroundColor(.gray)
                }
            }

            HStack{
                ForEach(0..<openningSteps.count) { it in
                    if it == currentStep {
                        Rectangle()
                                .frame(width: 80, height: 6)
                            .cornerRadius(5)
                                .foregroundColor(.black)
                    } else {
                        Rectangle()
                                .frame(width: 80, height: 6)
                            .cornerRadius(5)
                                .foregroundColor(.gray)
                    }
                }
            }
            .padding(.bottom, 24)

            TabView(selection: $currentStep){
                ForEach(0..<openningSteps.count) { it in
                    VStack{
                        Image(openningSteps[it].image)
                                .resizable()
                                .frame(width: 200, height: 200)
                        Text(openningSteps[it].text)
                                .font(.system(size: 22, weight: .regular, design: .rounded))
                            .padding(.top, 100)
                            .padding(.horizontal, 32)
                            .multilineTextAlignment(.center)
                    }
                    .tag(it)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            Button(action: {
                if self.currentStep < openningSteps.count - 1 {
                    self.currentStep += 1
                } else if self.currentStep == openningSteps.count - 1 {
                    LoginView()
                }
            }) {
                Text(currentStep < openningSteps.count - 1 ? "Next": "Get Started")
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(14)
                        .padding(.horizontal, 16)
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
            }
                .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    OpenningScreensView()
}
