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
        self.imageView.clipsToBounds = true
        self.imageView.image = frame?.image
        self.imageView.backgroundColor = .clear
        self.imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.imageView)
        
        self.layer.masksToBounds = false
        self.contentView.layer.masksToBounds = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.backgroundColor = UIColor.clear.cgColor
        guard let position = frame?.position else { return }
        self.roundCorners(for: position)
    }
    
    private func roundCorners(for position: FramePosition) {
        switch position {
        case .first:
            self.imageView.roundCorners([.topLeft, .bottomLeft], radius: 6)
        case .last:
            self.imageView.roundCorners([.topRight, .bottomRight], radius: 6)
        default:
            break
        }
    }
}
