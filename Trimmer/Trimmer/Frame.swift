//
//  Frame.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit

final class Frame {
    
    public let url: URL
    
    public let image: UIImage
    
    public init(url: URL, image: UIImage) {
        self.url = url
        self.image = image
    }
}

extension Frame: ListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self.url as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.url == (object as? Frame)?.url
    }
}
