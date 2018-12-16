//
//  TrimmerDimView.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-16.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit

final class TrimmerDimView: UIView {
    
    public var position: FramePosition = .inner
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch position {
        case .first:
            self.roundCorners([.topLeft, .bottomLeft], radius: 6)
        case .last:
            self.roundCorners([.topRight, .bottomRight], radius: 6)
        default:
            break
        }
    }
}
