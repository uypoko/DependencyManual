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
    
    var navigationObervable: Observable<MainNavigation> {
        return navigation.asObservable()
    }
    
    private let checkUserSession: CheckUserSession
    private let disposeBag = DisposeBag()
    private let navigation = PublishSubject<MainNavigation>()
    
    init(checkUserSession: CheckUserSession) {
        self.checkUserSession = checkUserSession
    }
    
    func getUserProfile() {
        checkUserSession.run().subscribe(onSuccess: { [unowned self] bool in
            if bool {
                self.navigation.onNext(.home)
            } else {
                self.navigation.onNext(.welcome)
            }
        }, onError: { [unowned self] error in
            self.navigation.onNext(.welcome)
            self.navigation.onError(SessionError.failedToReadUserSession)
        }).disposed(by: disposeBag)
    }
    
    func completeEvents() {
        navigation.onCompleted()
    }
}
