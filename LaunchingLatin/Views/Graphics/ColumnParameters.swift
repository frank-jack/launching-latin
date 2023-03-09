//
//  ColumnParameters.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/18/22.
//

import CoreGraphics

struct ColumnParameters {
    struct Segment {
        let line: CGPoint
    }

    static let segments = [
        Segment(
            line:    CGPoint(x: 0.2, y: 0.5)
        ),
        Segment(
            line:    CGPoint(x: 0.2, y: 6.5)
        ),
        Segment(
            line:    CGPoint(x: 0, y: 7)
        ),
        Segment(
            line:    CGPoint(x: 1, y: 7)
        ),
        Segment(
            line:    CGPoint(x: 0.8, y: 6.5)
        ),
        Segment(
            line:    CGPoint(x: 0.8, y: 0.5)
        ),
        Segment(
            line:    CGPoint(x: 1, y: 0)
        ),
        Segment(
            line:    CGPoint(x: 0, y: 0)
        )
    ]
}
