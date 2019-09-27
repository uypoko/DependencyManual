//
//  GetUserProfile.swift
//  DependencyManual
//
//  Created by Uy Cung Dinh on 9/19/19.
//  Copyright © 2019 Daylighter. All rights reserved.
//

import Foundation
import RxSwift

struct CheckUserSession {
    var userRepository: UserRepository
    
    func run() -> Single<Bool> {
        return userRepository.hasUserSession()
    }
}

protocol Runable {
    
}

extension Runable {
    func run() {
        print("run")
    }
}

protocol HasDisposeBag {
    var disposeBag: DisposeBag { get }
}

extension HasDisposeBag {
    func observe<T>(observable: Observable<T>, onSuccess: @escaping (T) -> Void) {
        observable.asObservable().subscribe(onNext: onSuccess, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
