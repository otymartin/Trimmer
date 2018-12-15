//
//  TrimmerSectionController.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit

public let FrameSize = CGSize(width: 56, height: 56)

final class FrameSectionController: ListSectionController {
    
    public var frame: Frame?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return FrameSize
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
