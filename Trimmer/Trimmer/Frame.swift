//
//  Frame.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit
import AVFoundation

final class Frame {
    
    public let index: CMTime

    public let image: UIImage?
    
    public init(index: CMTime, image: UIImage? = nil) {
        self.image = image
        self.index = index
    }
}

extension Frame: ListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self.index as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.index == (object as? Frame)?.index
    }
}
