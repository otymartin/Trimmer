//
//  Frame.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit

final class Frame {
    
    public let id = UUID.init()

    public let image: UIImage
    
    public init(image: UIImage) {
        self.image = image
    }
}

extension Frame: ListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.id == (object as? Frame)?.id
    }
}
