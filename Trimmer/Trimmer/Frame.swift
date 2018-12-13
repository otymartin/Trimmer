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
    
    public let time: CMTime

    public var image: UIImage?
    
    public init(time: CMTime, image: UIImage? = nil) {
        self.image = image
        self.time = time
    }
}

extension Frame: ListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self.time as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.time.value == (object as? Frame)?.time.value
    }
}
