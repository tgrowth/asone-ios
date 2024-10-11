//
//  InvitePartnerView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/9/24.
//


import SwiftUI

struct InvitePartnerView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var isCopied = false
    @State private var partnerCode: String = ""
    @State private var showError: Bool = false
    
    // Function to validate the partner's code
    func isValidCode(_ code: String) -> Bool {
        return !code.isEmpty && code.count == 6 // Simple validation for a 6-character code
    }
    
    // Function to pair with the partner using the code
    func pairWithPartner(code: String) {
        // Pairing logic goes here
        print("Pairing with partner's code: \(code)")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Title
            Text("Pair with your partner")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            // Description
            Text("Pair with your partner to boost your relationship and communication")
                .font(.body)
                .foregroundColor(.gray)
            
            // Invite code card
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Invite your partner")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    
                    // Copy button
                    Button(action: {
                        UIPasteboard.general.string = profileViewModel.currentUser?.inviteCode
                        isCopied = true
                    }) {
                        HStack {
                            Image(systemName: isCopied ? "checkmark" : "doc.on.doc")
                            Text(isCopied ? "Copied" : "Tap to copy")
                        }
                        .foregroundColor(.black)
                        .font(.caption)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                }
                
                // Invite code section
                VStack(spacing: 10) {
                    Text("Your code:")
                        .font(.subheadline)
                    
                    Text(profileViewModel.currentUser?.inviteCode ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                
                // Share invite button
                Button(action: {
                    // Share code action
                    shareCode(profileViewModel.currentUser?.inviteCode ?? "")
                }) {
                    Text("Share my invite code")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            
            Text("─────────   OR   ─────────")
            
            // Enter code card
            VStack(alignment: .leading, spacing: 10) {
                Text("Enter partner's code")
                    .font(.title3)
                    .fontWeight(.bold)
                
                // TextField for entering code
                TextField("Enter code here", text: $partnerCode)
                    .font(.title3)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .autocapitalization(.allCharacters) // Automatically capitalizes the code
                
                // Error message if code is invalid
                if showError {
                    Text("Invalid code. Please try again.")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                // Submit button
                Button(action: {
                    // Action to validate and pair with partner's code
                    if isValidCode(partnerCode) {
                        // Proceed with pairing logic
                        pairWithPartner(code: partnerCode)
                    } else {
                        // Show error if code is invalid
                        showError = true
                    }
                }) {
                    Text("Enter partner's code")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
        
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    func shareCode(_ code: String) {
        // Share code functionality
        let activityVC = UIActivityViewController(activityItems: [code], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
}

#Preview {
    InvitePartnerView()
}
