//
//  TrimmerSectionController.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit

public struct FrameSectionMath {
    
    public static var selectorBorderWidth: CGFloat {
        return 3
    }
    
    private static var collectionViewHeight: CGFloat {
        return 66
    }
    
    public static var selectorLeftOffset: CGFloat {
        return self.collectionViewSize.width - ((self.frameSize.width * 3) + self.selectorBorderWidth)
    }
    
    public static var collectionViewContentOffset: CGFloat {
        return self.collectionViewSize.width - (self.frameSize.width * 3)
    }
    
    public static var collectionViewSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: self.collectionViewHeight)
    }
    
    public static var insets: UIEdgeInsets {
        return UIEdgeInsets(top: self.selectorBorderWidth, left: 0, bottom: self.selectorBorderWidth, right: 1.5)
    }
    
    public static var selectorSize: CGSize {
        return CGSize(width: (self.frameSize.width * 2) + (self.selectorBorderWidth * 2), height: self.frameSize.height + (self.selectorBorderWidth * 2))
    }
    
    public static var frameSize: CGSize {
        return CGSize(width: self.collectionViewSize.height - (self.selectorBorderWidth * 2), height: self.collectionViewSize.height - (self.selectorBorderWidth * 2))
    }
}

final class FrameSectionController: ListSectionController {
    
    public var frame: Frame?
    
    override init() {
        super.init()
        self.inset = FrameSectionMath.insets
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return FrameSectionMath.frameSize
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = self.collectionContext?.dequeueReusableCell(of: FrameCell.self, for: self, at: index) as? FrameCell else {
            fatalError()
        }
        cell.configure(with: self.frame)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.frame = object as? Frame
    }
}
