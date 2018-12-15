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
    
    public func add(_ newFrame: Frame) -> FrameSectionModel {
        var frames = self.frames
        let oldFrame = frames.filter { $0.time == newFrame.time }.first
        if let oldFrame = oldFrame, let indexOfOldFrame = frames.firstIndex(of: oldFrame) {
            frames.remove(at: indexOfOldFrame)
            frames.insert(newFrame, at: indexOfOldFrame)
        }
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
