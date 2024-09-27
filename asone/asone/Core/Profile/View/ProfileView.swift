//
//  ProfileView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 9/26/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                   
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.black)
                    }
                }
            }
        }

    }
}

#Preview {
    ProfileView()
}
