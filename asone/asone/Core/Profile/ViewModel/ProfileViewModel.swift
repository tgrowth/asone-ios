//
//  ProfileViewModel.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/2/24.
//

import Foundation
import Combine
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        setUpSubscribers()
    }
    
    private func setUpSubscribers(){
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
}
