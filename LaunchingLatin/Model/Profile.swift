//
//  Profile.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/15/22.
//

import Foundation

struct Profile {
    var username: String
    var userId: String
    var prefersNotifications: Bool
    var coinAmount: Int
    var storage: [Int]

    static let `default` = Profile(username: "default", userId: "", prefersNotifications: true, coinAmount: 0, storage: [])

}
