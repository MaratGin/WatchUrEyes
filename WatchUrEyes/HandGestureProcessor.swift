//
//  HandGestureProcessor.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 08.11.2023.
//

import Foundation

class HandGestureProcessor {
    enum State {
        case possiblePinch
        case pinched
        case possibleApart
        case apart
        case unknown
    }
    
    typealias PointsPair = (thumbTip: CGPoint, indexTip: CGPoint, middleTip: CGPoint, ringTip: CGPoint, pinkyTip: CGPoint)
    
    private var state = State.unknown {
        didSet {
            didChangeStateClosure?(state)
        }
    }
    private var apartEvidenceCounter = 0
    private let pinchMaxDistance: CGFloat
    private let evidenceCounterStateTrigger: Int
    
    var didChangeStateClosure: ((State) -> Void)?
    private (set) var lastProcessedPointsPair = PointsPair(.zero, .zero, .zero, .zero, .zero)
    
    init(pinchMaxDistance: CGFloat = 40, evidenceCounterStateTrigger: Int = 3) {
        self.pinchMaxDistance = pinchMaxDistance
        self.evidenceCounterStateTrigger = evidenceCounterStateTrigger
    }
    
    func reset() {
        state = .unknown
        apartEvidenceCounter = 0
    }
    
    func processPointsPair(_ pointsPair: PointsPair) {
        lastProcessedPointsPair = pointsPair
        
            apartEvidenceCounter += 1
            // Set new state based on evidence amount.
            state = (apartEvidenceCounter >= evidenceCounterStateTrigger) ? .apart : .possibleApart
    }
}

// MARK: - CGPoint helpers

extension CGPoint {

    static func midPoint(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
    }
    
    func distance(from point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
}
