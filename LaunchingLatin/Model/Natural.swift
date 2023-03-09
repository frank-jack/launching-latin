//
//  Natural.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 7/4/22.
//

import Foundation
import SwiftUI

struct Natural: Hashable, Codable, Identifiable {
    var english: String
    var latin: String
    var id: Int
    
    var image: Image {
        Image(english)
    }
}
