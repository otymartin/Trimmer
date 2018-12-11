//
//  TrimmerSectionController.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit

final class FrameSectionController: ListSectionController {
    
    public var image: UIImage?
    
    override func sizeForItem(at index: Int) -> CGSize {
        
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
    }
    
    override func didUpdate(to object: Any) {
        self.image = object as? UIImage
    }
}
