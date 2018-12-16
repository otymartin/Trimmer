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

    private lazy var imageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}

extension FrameCell {
    
    public func configure(with frame: Frame?) {
        self.layer.shouldRasterize = true
        self.imageView.frame = self.bounds
        self.imageView.image = frame?.image
        self.imageView.backgroundColor = .clear
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.imageView)
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.masksToBounds = false
        self.contentView.layer.masksToBounds = true
        self.layer.backgroundColor = UIColor.clear.cgColor
        guard let position = frame?.position else { return }
        self.roundCorners(for: position)
    }
    
    private func roundCorners(for position: FramePosition) {
        print("Position: \(position)")
        switch position {
        case .first:
            self.imageView.setCornerRadius(radius: 6)
            self.layer.cornerRadius = 6
            self.layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 6).cgPath
            //self.imageView.roundCorners(UIRectCorner.topLeft.union(UIRectCorner.bottomLeft), radius: 6)
            //self.contentView.roundCorners(UIRectCorner.topLeft.union(UIRectCorner.bottomLeft), radius: 6)
        case .last:
            self.imageView.setCornerRadius(radius: 6)
            self.layer.cornerRadius = 6
            self.layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 6).cgPath
            //self.imageView.roundCorners(UIRectCorner.topRight.union(UIRectCorner.bottomRight), radius: 6)
            //self.contentView.roundCorners(UIRectCorner.topRight.union(UIRectCorner.bottomRight), radius: 6)
        default:
            break
        }
    }
}
