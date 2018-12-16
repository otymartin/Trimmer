//
//  FrameCell.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit

enum CornersToRound {
    case left
    case right
    case none
}

final class FrameCell: UICollectionViewCell {
    
    public var shouldRoundCorners: CornersToRound = .none {
        didSet {
            self.roundCorners()
        }
    }

    private lazy var imageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}

extension FrameCell {
    
    public func configure(with frame: Frame?) {
        self.imageView.frame = self.bounds
        self.imageView.image = frame?.image
        self.imageView.clipsToBounds = true
        self.imageView.backgroundColor = .clear
        self.imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.imageView)
        self.roundCorners()
    }
    
    private func roundCorners() {
        switch shouldRoundCorners {
        case .left:
            self.contentView.roundCorners(UIRectCorner.topLeft.union(UIRectCorner.bottomLeft), radius: 6)
        case .right:
            self.contentView.roundCorners(UIRectCorner.topRight.union(UIRectCorner.bottomRight), radius: 6)
        default:
            break
        }
    }
}
