//
//  TimerSelector.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-15.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit
import AVFoundation

protocol TrimmerViewDelegate: class {
    
    func resumePlayback()
    
    func seek(to time: CMTime)
    
    var collectionView: UICollectionView { get set }
    
    func dimView(leftOverflow: CGFloat, rightOverflow: CGFloat)
}

extension TrimmerViewDelegate {
    
    func dimView(leftOffset: CGFloat) {}
}

final class TimeSelector: NSObject {
    
    /// The video asset being trimmed.
    public var asset: AVAsset?
    
    /// The reciever of callbacks when user selects a starting time to trim the AVAsset.
    public weak var delegate: TrimmerViewDelegate?
    
    /// The time stamp on the AVAsset when the trimmer stops dragging.
    private var selectedTime: CMTime? {
        guard let duration = self.asset?.duration.seconds else { return nil }
        let timeStamp = CGFloat(duration).multiplied(by: self.currentPositionAsPercentOfContentSize)
        return CMTime(seconds: Double(timeStamp), preferredTimescale: 600)
    }
    
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
        return self.currentPosition.divided(by: self.contentSize.width)
    }
    
    /// The adjusted offset of the contentView.
    private var contentOffset: CGFloat? {
        return self.delegate?.collectionView.contentOffset.x.add(self.startingPosition)
    }
    
    /// The contentSize of the AVAsset's Frames.
    private var contentSize: CGSize {
        return self.delegate?.collectionView.contentSize ?? .zero
    }
    
    private var leftOverflow: CGFloat {
        return -(self.contentOffset ?? 0 < 0 ? 0 : self.contentOffset ?? 0).subtract(FrameSectionMath.selectorBorderWidth)
    }
    
    private var rightOverflow: CGFloat {
        let value = self.contentSize.width.subtract(self.leftOverflow.add(FrameSectionMath.frameSize.width.multiplied(by: 2)))
        return value < 0.0 ? 0 : value
    }
    
}

extension TimeSelector: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("CONTENT SIZE \(self.contentSize.width)")
        print("LEFT OVERFLOW \(self.leftOverflow)")
        print(self.rightOverflow)
        self.delegate?.dimView(leftOverflow: self.leftOverflow, rightOverflow: self.rightOverflow)
        guard let selectedTime = self.selectedTime else { return }
        self.delegate?.seek(to: selectedTime)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.delegate?.resumePlayback()
    }
}
