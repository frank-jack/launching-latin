//
//  StoreFront.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/28/22.
//

import SwiftUI

struct StoreFront: View {
    var item: StoreItem
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                item.image
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
                Text(item.name)
                    .multilineTextAlignment(.center)
            }
            .padding(.leading, 15)
        }
    }
}

struct StoreFront_Previews: PreviewProvider {
    static var previews: some View {
        StoreFront(item: ModelData().store[0])
    }
}
