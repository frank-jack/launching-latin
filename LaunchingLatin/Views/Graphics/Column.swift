//
//  Column.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/18/22.
//

import SwiftUI

struct Column: View {
    var body: some View {
        Path { path in
            path.move(
                to: CGPoint(
                    x: 0,
                    y: 0
                )
            )
            ColumnParameters.segments.forEach { segment in
                path.addLine(
                    to: CGPoint(
                        x: 75 * segment.line.x,
                        y: 75 * segment.line.y
                    )
                )
            }
        }
        .fill(Color.yellow)
        .opacity(0.4)
        .padding()
    }
}

struct Column_Previews: PreviewProvider {
    static var previews: some View {
        Column()
    }
}
