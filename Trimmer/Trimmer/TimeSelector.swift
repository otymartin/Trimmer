//
//  TimerSelector.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-15.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit
import AVFoundation

final class TimeSelector: NSObject {
    
    public weak var delegate: TrimmerView?
    
    private var startingPosition: CGFloat {
        return FrameSectionMath.collectionViewSize.width.subtract(FrameSectionMath.visibleFramesWidth)
    }
    
    public var adjustedStartingPosition: CGFloat {
        return self.startingPosition.subtract(self.startingPosition)
    }
    
    private var virtualPosition: CGFloat {
        let offset = self.contentOffset ?? 0
        switch offset {
        case _ where offset < 0.0:
            return self.adjustedStartingPosition
        default:
            return self.adjustedStartingPosition.add(offset)
        }
    }
    
    private var currentPosition: CGFloat {
        switch self.virtualPosition {
        case _ where self.virtualPosition < 0.0:
            return self.adjustedStartingPosition
        case _ where self.virtualPosition > self.contentSize.width:
            return self.adjustedStartingPosition + self.contentSize.width
        default:
            return self.self.virtualPosition
        }
    }
    
    private var currentPositionAsPercentOfContentSize: CGFloat {
        return self.currentPosition.divided(by: self.contentSize.width).multiplied(by: 100)
    }
    
    private var contentOffset: CGFloat? {
        return self.delegate?.collectionView.contentOffset.x.add(self.startingPosition)
    }
    
    private var contentSize: CGSize {
        return self.delegate?.collectionView.contentSize ?? .zero
    }
    
}

extension TimeSelector: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("CURRENT POSITION \(self.currentPosition)")
        print("CURRENT POSITION %\(self.currentPositionAsPercentOfContentSize)")
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
