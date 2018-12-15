//
//  FrameSectionModel.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-14.
//  Copyright © 2018 Capsule. All rights reserved.
//

import IGListKit

final class FrameSectionModel {
    
    public let frames: [Frame] = []
    
    init(frames: [Frame]) {
        self.frames = frames
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
