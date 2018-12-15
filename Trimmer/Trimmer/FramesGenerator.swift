//
//  FramesManager.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-15.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit
import AVFoundation

protocol FramesGeneratorDelegate: class {
    
    func didGenerate(_ frames: FrameSectionModel)
    
}

final class FramesGenerator {
    
    private var generator: AVAssetImageGenerator?
    
    public weak var delegate: FramesGeneratorDelegate?
    
}

extension FramesGenerator {
    
    public func generate(for asset: AVAsset) {
        self.generator = AVAssetImageGenerator(asset: asset)
        self.generator?.requestedTimeToleranceAfter = .zero
        self.generator?.requestedTimeToleranceBefore = .zero
        self.generator?.appliesPreferredTrackTransform = true
        let scaledSize = CGSize(width: UIScreen.main.bounds.width * UIScreen.main.scale, height: UIScreen.main.bounds.height * UIScreen.main.scale)
        self.generator?.maximumSize = scaledSize
        let numberOfThumbnails = Int(ceil(asset.duration.seconds)) + 1
        var times = [NSValue]()
        var frames: [Frame] = []
        let lastIndex = numberOfThumbnails - 1
        for index in 0..<numberOfThumbnails {
            let time = CMTime(seconds: index == lastIndex ? asset.duration.seconds: Double(index), preferredTimescale: 600)
            let value = NSValue(time: time)
            times.append(value)
            frames.append(Frame(time: time))
        }
        self.delegate?.didGenerate(FrameSectionModel(frames: frames))
    }
    
    private func generateThumnails(at times: [NSValue], for section: FrameSectionModel) {
        self.generator?.generateCGImagesAsynchronously(forTimes: times) { (requestedTime, cgImage, actualTime, result, error) in
            if error == nil, result == .succeeded, let cgImage = cgImage {
                let newFrame = Frame(time: requestedTime, image: UIImage(cgImage: cgImage))
                let newSection = section.add(newFrame)
                DispatchQueue.main.async {
                    self.delegate?.didGenerate(newSection)
                }
            }
        }
    }
}
