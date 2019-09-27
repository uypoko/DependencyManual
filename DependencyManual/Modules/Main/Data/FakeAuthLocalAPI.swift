//
//  FakeAuthRemoteAPI.swift
//  DependencyManual
//
//  Created by Uy Cung Dinh on 9/19/19.
//  Copyright © 2019 Daylighter. All rights reserved.
//

import Foundation
import RxSwift

struct FakeAuthLocalAPI: UserRepository {
    // MARK: - Properties
    var docsURL: URL? {
      return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                      in: FileManager.SearchPathDomainMask.allDomainsMask).first
    }

    // MARK: - Methods
    
    func hasUserSession() -> Single<Bool> {
        return Single<Bool>.create(subscribe: { single in
            guard let docsURL = self.docsURL else {
                single(.error(SessionError.failedToReadUserSession))
                return Disposables.create()
            }
            
            let decoder = JSONDecoder()
            if let jsonData = try? Data(contentsOf: docsURL.appendingPathComponent("user_session.json")),
                (try? decoder.decode(UserProfile.self, from: jsonData)) != nil {
                single(.success(true))
            } else {
                single(.success(false))
            }
            
            return Disposables.create()
        })
    }
}
