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
    
    /// The absolute X position of our virtual time selector on the scrollView.
    private var startingPosition: CGFloat {
        return FrameSectionMath.collectionViewSize.width.subtract(FrameSectionMath.visibleFramesWidth)
    }
    
    /// The starting position adjusting for offset of the trimmer view on the collectionView.
    public var adjustedStartingPosition: CGFloat {
        return self.startingPosition.subtract(self.startingPosition)
    }
    
    /// The x value of the invisible time selector with adjusted to not go negative or exceed the contentSize
    private var x: CGFloat {
        let offset = self.contentOffset ?? 0
        switch offset {
        case _ where offset < 0.0:
            return self.adjustedStartingPosition
        default:
            return self.adjustedStartingPosition.add(offset)
        }
    }
    
    /// The current position of our invisible time selector adjusted for content offsets.
    private var currentPosition: CGFloat {
        switch self.x {
        case _ where self.x < 0.0:
            return self.adjustedStartingPosition
        case _ where self.x > self.contentSize.width:
            return self.adjustedStartingPosition + self.contentSize.width
        default:
            return self.self.x
        }
    }
    
    /// The current position of our invisible time selector expressed as a percentage of the overall contentSize
    private var currentPositionAsPercentOfContentSize: CGFloat {
        return self.currentPosition.divided(by: self.contentSize.width).multiplied(by: 100)
    }
    
    /// The adjusted offset of the contentView.
    private var contentOffset: CGFloat? {
        return self.delegate?.collectionView.contentOffset.x.add(self.startingPosition)
    }
    
    /// The contentSize of the AVAsset's Frames.
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
