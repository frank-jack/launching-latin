//
//  Shape.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 7/5/22.
//

import Foundation
import SwiftUI

struct Shape: Hashable, Codable, Identifiable {
    var english: String
    var latin: String
    var id: Int
    
    var image: Image {
        Image(english)
    }
}
