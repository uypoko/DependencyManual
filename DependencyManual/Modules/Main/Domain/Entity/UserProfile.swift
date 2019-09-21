//
//  UserProfile.swift
//  DependencyManual
//
//  Created by Uy Cung Dinh on 9/19/19.
//  Copyright © 2019 Daylighter. All rights reserved.
//

import Foundation

class UserProfile: Codable {
    let id: String
    var name: String
    var points: Int
    
    init(id: String, name: String, points: Int) {
        self.id = id
        self.name = name
        self.points = points
    }
}
