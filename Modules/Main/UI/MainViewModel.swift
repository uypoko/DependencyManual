//
//  MainViewModel.swift
//  DependencyManual
//
//  Created by Uy Cung Dinh on 9/21/19.
//  Copyright © 2019 Daylighter. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel {
    private let userRepository: UserRepository
    
    let navigation = PublishSubject<MainNavigation>()
    let userProfile = PublishSubject<UserProfile?>()
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func getUserProfile() {
        userRepository.readUserSession().done { [unowned self] user in
            self.userProfile.onNext(user)
            if user != nil {
                self.navigation.onNext(.home)
            } else {
                self.navigation.onNext(.welcome)
            }
        }.catch { [unowned self] _ in
            self.userProfile.onError(SessionError.failedToReadUserSession)
        }
    }
}
