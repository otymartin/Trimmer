//
//  TrimmerSectionController.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit

final class FrameSectionController: ListSectionController {
    
    public var frame: Frame?
    
    override func sizeForItem(at index: Int) -> CGSize {
        
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = self.collectionContext?.dequeueReusableCell(of: FrameCell.self, for: self, at: index) as? FrameCell, let frame = self.frame else {
            fatalError()
        }
        cell.configure(with: frame)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.frame = object as? Frame
    }
}
