//
//  Test.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/20/22.
//

import SwiftUI
import ConfettiSwiftUI

struct Test: View {
    @State private var show = true
    @State private var rocketLaunched = false
    @State private var rc = Image("coin")
    @State private var c = 0
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea(.all)
            VStack {
                Button("Test") {
                    withAnimation(.easeInOut(duration: 3.0)) {
                            show = false
                        }
                }
                if show {
                    rc
                        .resizable()
                        .frame(width: 30, height: 30)
                        .transition(.offset(x: UIScreen.main.bounds.width, y: -UIScreen.main.bounds.height))
                }
                if !rocketLaunched {
                    Image("rocket")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .position(x: 0, y: 0)
                        .transition(.offset(x: 100, y: 100))
                }
                Button("Test") {
                    withAnimation (.easeInOut(duration: 3.0)) {
                        
                        rocketLaunched = true
                    }
                }
                Button(action: {
                            c += 1
                        }) {
                            Text("🎃")
                                .font(.system(size: 50))
                        }
                        .confettiCannon(counter: $c)
                Button("TestC") {
                    if rocketLaunched {
                        c+=1
                    } else {
                        
                    }
                }
                .confettiCannon(counter: $c)
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
