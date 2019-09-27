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
    private let homeViewControllerFactory: () -> HomeViewController
    private let welcomeViewControllerFactory: () -> WelcomeViewController
    
    init(viewModel: MainViewModel,
        homeViewControllerFactory: @escaping () -> HomeViewController,
        welcomeViewControllerFactory: @escaping () -> WelcomeViewController) {
        self.viewModel = viewModel
        self.homeViewControllerFactory = homeViewControllerFactory
        self.welcomeViewControllerFactory = welcomeViewControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUserProfile()
        subscribe()
    }
    
    func subscribe() {
        viewModel.navigationObervable.subscribe(
                onNext: { [weak self] mainNavigation in
                    guard let self = self else { return }
                    self.present(view: mainNavigation)
            }).disposed(by: disposeBag)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.completeEvents()
    }
    
    func present(view: MainNavigation) {
        switch view {
        case .home:
            self.navigationController?.pushViewController(homeViewControllerFactory(), animated: true)
        case .welcome:
            self.navigationController?.pushViewController(welcomeViewControllerFactory(), animated: true)
        }
    }

}
