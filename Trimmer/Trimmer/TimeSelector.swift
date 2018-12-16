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
    
    private var virtualPosition: CGFloat?
    
    public weak var delegate: TrimmerView?
    
    public var initialPosition: CGFloat {
        return FrameSectionMath.collectionViewSize.width - (FrameSectionMath.frameSize.width * 3)
    }
    
    public var offset: CGFloat? {
        return self.delegate?.collectionView.contentOffset.x
    }
}

extension TimeSelector: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
