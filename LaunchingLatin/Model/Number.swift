//
//  Numbers.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/13/22.
//

import Foundation
import SwiftUI

struct Number: Hashable, Codable, Identifiable {
    var number: String
    var english: String
    var latin: String
    var id: Int
}
