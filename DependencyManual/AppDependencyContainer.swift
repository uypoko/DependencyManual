//
//  AppDependencyContainer.swift
//  DependencyManual
//
//  Created by Uy Cung Dinh on 9/19/19.
//  Copyright © 2019 Daylighter. All rights reserved.
//

import Foundation

class AppDependencyContainer {
    
    func makeMainViewController() -> MainViewController {
        let userRepository: UserRepository = FakeAuthLocalAPI()
        let checkUserSession = CheckUserSession(userRepository: userRepository)
        let mainViewModel = MainViewModel(checkUserSession: checkUserSession)
        let mainViewController = MainViewController(
            viewModel: mainViewModel,
            homeViewController: { self.makeHomeViewController() },
            welcomeViewController: { self.makeWelcomeViewController() } )
        return mainViewController
    }
    
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController()
    }
    
    func makeWelcomeViewController() -> WelcomeViewController {
        return WelcomeViewController()
    }
}
