//
//  Frame.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit
import AVFoundation

public enum FramePosition {
    case first
    case last
    case inner
}

final class Frame {
    
    public let time: CMTime

    public var image: UIImage?
    
    public var position: FramePosition
    
    public init(time: CMTime, position: FramePosition = .inner, image: UIImage? = nil) {
        self.time = time
        self.image = image
        self.position = position
    }
}

extension Frame: ListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self.time as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.time == (object as? Frame)?.time && self.image == (object as? Frame)?.image && self.position == (object as? Frame)?.position
    }
}

extension Frame: Equatable {
    
    public static func ==(lhs: Frame, rhs: Frame) -> Bool {
        return lhs.time == rhs.time && lhs.image == rhs.image && lhs.position == rhs.position
    }
}
