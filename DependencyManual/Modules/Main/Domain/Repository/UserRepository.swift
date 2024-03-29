//
//  UserRepository.swift
//  DependencyManual
//
//  Created by Uy Cung Dinh on 9/19/19.
//  Copyright © 2019 Daylighter. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepository {
    func hasUserSession() -> Single<Bool>
}
