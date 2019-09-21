//
//  MainViewController.swift
//  DependencyManual
//
//  Created by Uy Cung Dinh on 9/21/19.
//  Copyright © 2019 Daylighter. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: NiblessViewController {
    
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    // Factories
    private let homeViewController: () -> HomeViewController
    private let welcomeViewController: () -> WelcomeViewController
    
    init(viewModel: MainViewModel,
         homeViewController: @escaping () -> HomeViewController,
         welcomeViewController: @escaping () -> WelcomeViewController) {
        self.viewModel = viewModel
        self.homeViewController = homeViewController
        self.welcomeViewController = welcomeViewController
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUserProfile()
        subscribe()
    }
    
    func subscribe() {
        viewModel.navigation.subscribe(onNext: { mainNavigation in
            self.present(view: mainNavigation)
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        viewModel.userProfile.subscribe(onError: { error in
            // present error
            }).disposed(by: disposeBag)
    }
    
    func present(view: MainNavigation) {
        switch view {
        case .home:
            self.navigationController?.pushViewController(homeViewController(), animated: true)
        case .welcome:
            self.navigationController?.pushViewController(welcomeViewController(), animated: true)
        }
    }

}
