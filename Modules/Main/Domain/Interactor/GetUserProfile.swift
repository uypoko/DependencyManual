//
//  GetUserProfile.swift
//  DependencyManual
//
//  Created by Uy Cung Dinh on 9/19/19.
//  Copyright © 2019 Daylighter. All rights reserved.
//

import Foundation
import PromiseKit

struct GetUserProfile {
    var userRepository: UserRepository
    
    func getUserProfile() -> Promise<UserProfile?> {
        return userRepository.readUserSession()
    }
}
