//
//  Store.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/28/22.
//

import Foundation
import SwiftUI

struct StoreItem: Hashable, Codable, Identifiable {
    var name: String
    var cost: Int
    var id: Int
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
