//
//  FrameCell.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit

final class FrameCell: UICollectionViewCell {
    
    private lazy var imageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}

extension FrameCell {
    
    public func configure(with frame: Frame) {
        self.imageView.frame = self.bounds
        self.imageView.image = frame.image
        self.imageView.clipsToBounds = true
        self.imageView.backgroundColor = .black
        self.imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.contentView)
    }
}
