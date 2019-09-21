//
//  FakeAuthRemoteAPI.swift
//  DependencyManual
//
//  Created by Uy Cung Dinh on 9/19/19.
//  Copyright © 2019 Daylighter. All rights reserved.
//

import Foundation
import PromiseKit

struct FakeAuthLocalAPI: UserRepository {
    // MARK: - Properties
    var docsURL: URL? {
      return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                      in: FileManager.SearchPathDomainMask.allDomainsMask).first
    }

    // MARK: - Methods

    public func readUserSession() -> Promise<UserProfile?> {
      return Promise() { seal in
        guard let docsURL = docsURL else {
            seal.reject(SessionError.failedToReadUserSession)
          return
        }
        guard let jsonData = try? Data(contentsOf: docsURL.appendingPathComponent("user_session.json")) else {
          seal.fulfill(nil)
          return
        }
        let decoder = JSONDecoder()
        let userSession = try! decoder.decode(UserProfile.self, from: jsonData)
        seal.fulfill(userSession)
      }
    }
}
