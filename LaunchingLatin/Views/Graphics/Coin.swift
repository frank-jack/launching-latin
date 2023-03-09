//
//  CoinBackground.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/17/22.
//

import SwiftUI

struct Coin: View {
    var radius: CGFloat
    var body: some View {
        Circle()
            .fill(Color.yellow)
            .frame(width: radius, height: radius)
            .overlay {
                Circle()
                    .stroke(Color.gray)
                    .frame(width: radius*4/5, height: radius*4/5)
                    .overlay {
                        Text("L")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
            }
    }
}

struct Coin_Previews: PreviewProvider {
    static var previews: some View {
        Coin(radius: 200)
    }
}
