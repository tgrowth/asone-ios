//
//  OnboardingStep2View.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/24/24.
//

import SwiftUI

struct OnboardingStep7View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var isSharing = false

    var body: some View {
        VStack {
            Text("Partner Mode")
                .font(.headline)
            
            Picker("", selection: $viewModel.userData.isPartnerMode) {
                Text("Invite partner").tag(true)
                Text("I'm not interested").tag(false)
            }
            .pickerStyle(.segmented)
            
            if viewModel.userData.isPartnerMode {
                VStack(spacing: 16) {                    
                    Text("\(viewModel.userData.inviteCode)")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Button(action: {
                        isSharing = true
                    }) {
                        HStack {
                            Text("Share invite code").foregroundColor(.white)
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                    }
                    .sheet(isPresented: $isSharing, onDismiss: {
                        print("Dismissed")
                    }) {
                        ActivityView(activityItems: [URL(string: "https://asone.com/?ref=\(viewModel.userData.inviteCode)")!])
                    }
                }
                .padding()
            }

            Spacer()
            HStack{
                OnboardingNavigation(
                    showNext: false,
                    backAction: viewModel.goToPreviousStep
                ) {
                        
                }
                Button(action: {
                    viewModel.completeOnboarding()
                }) {
                    HStack {
                        Text("Done").foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}


#Preview {
    OnboardingStep7View(viewModel: OnboardingViewModel())
}

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
