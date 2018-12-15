//
//  FrameSectionModel.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-14.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit

final class FrameSectionModel {
    
    public let frames: [Frame]
    
    init(frames: [Frame] = []) {
        self.frames = frames
    }
}

extension FrameSectionModel {
    
    public func set(_ thumbnail: UIImage, to frame: Frame) -> FrameSectionModel {
        var frames = self.frames
        if let index = frames.firstIndex(of: frame) {
            frames.remove(at: index)
        }
        frames.append(Frame(time: frame.time, image: thumbnail))
        frames.sort { $0.time.value < $1.time.value }
        return FrameSectionModel(frames: frames)
    }
}

extension FrameSectionModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return "FrameSectionModel" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.frames == (object as? FrameSectionModel)?.frames
    }
}
