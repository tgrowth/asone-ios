//
//  InvitePartnerView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/9/24.
//


import SwiftUI
import FirebaseAuth

struct InvitePartnerView: View {
    @ObservedObject private var viewModel = InvitePartnerViewModel()
    @State private var isCopied = false
    @State private var partnerCode: String = ""
    @State private var showError: Bool = false
    
    func isValidCode(_ code: String) -> Bool {
        return !code.isEmpty && code.count == 6
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Boost your relationship and communication")
                .font(.body)
                .foregroundColor(.gray)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Invite your partner")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    
                    Button(action: {
                        if let code = viewModel.inviteCode {
                            UIPasteboard.general.string = code
                            isCopied = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isCopied = false
                            }
                        }
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
                
                VStack(spacing: 10) {
                    Text("Your code:")
                        .font(.subheadline)
                    
                    if let inviteCode = viewModel.inviteCode {
                        Text(inviteCode)
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
                    } else {
                        Text("Generating code...")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                
                Button(action: {
                    if let code = viewModel.inviteCode {
                        shareCode(code)
                    }
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
            
            Text("─────────   OR   ─────────").foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Enter partner's code")
                    .font(.title3)
                    .fontWeight(.bold)
                
                TextField("Enter code here", text: $partnerCode)
                    .font(.title3)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .autocapitalization(.allCharacters)
                    .onChange(of: partnerCode) { newValue in
                        if isValidCode(newValue) {
                            showError = false
                        }
                    }
                
                if showError || viewModel.errorMessage != nil {
                    Text(viewModel.errorMessage ?? "Invalid code. Please try again.")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: {
                    if isValidCode(partnerCode) {
                        if let uid = AuthService.shared.userSession?.uid {
                            viewModel.pairPartner(uid: uid, code: partnerCode)
                        } else {
                            viewModel.errorMessage = "User not authenticated."
                        }
                    } else {
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
        .navigationTitle("Pair with your partner")
        .padding()
    }
    
    func shareCode(_ code: String) {
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
