//
//  TrimmerView.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit
import IGListKit
import AVFoundation

final class TrimmerView: UIView {
    
    private var model = FrameSectionModel()
    
    public lazy var selector = UIView()
        
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    
    public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .horizontal, topContentInset: 0, stretchToEdge: false))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TrimmerView: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.model.frames as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FrameSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }

}

extension TrimmerView {
    
    /// Generate thumbnail images from AVAsset, initialize Frame objects and update collectionView after asyncronously Fetching thumbnail images
    public func set(_ asset: AVAsset) {
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let scaledSize = CGSize(width: UIScreen.main.bounds.width * UIScreen.main.scale, height: UIScreen.main.bounds.height * UIScreen.main.scale)
        generator.maximumSize = scaledSize
        let numberOfThumbnails = Int(ceil(asset.duration.seconds)) + 1
        var times = [NSValue]()
        var thumbnailFrames: [Frame] = []
        for index in 0..<numberOfThumbnails {
            let time = CMTime(seconds: Double(index), preferredTimescale: 600)
            let value = NSValue(time: time)
            times.append(value)
            thumbnailFrames.append(Frame(time: time))
        }
        self.model = FrameSectionModel(frames: thumbnailFrames)
        generator.generateCGImagesAsynchronously(forTimes: times) { (requestedTime, cgImage, actualTime, result, error) in
            if error == nil, result == .succeeded, let cgImage = cgImage {
                let newFrame = Frame(time: requestedTime, image: UIImage(cgImage: cgImage))
                self.model = self.model.add(newFrame)
                DispatchQueue.main.async {
                     self.adapter.performUpdates(animated: true, completion: nil)
                }
            }
        }
    }
}

extension TrimmerView {
    
    private func configure() {
        self.configureCollectionView()
        self.addSelector()
    }
    
    private func configureCollectionView() {
        self.adapter.dataSource = self
        self.collectionView.bounces = true
        self.collectionView.frame = self.bounds
        self.collectionView.backgroundColor = .yellow
        self.adapter.collectionView = self.collectionView
        self.collectionView.alwaysBounceHorizontal = true
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: FrameSectionMath.collectionViewContentOffset, bottom: 0, right: FrameSectionMath.frameSize.width)
        self.addSubview(self.collectionView)
    }
    
    private func addSelector() {
        self.selector.layer.cornerRadius = 6
        self.selector.backgroundColor = .clear
        self.selector.isUserInteractionEnabled = false
        self.selector.layer.borderColor = UIColor.red.cgColor
        self.selector.layer.borderWidth = FrameSectionMath.selectorBorderWidth
        self.addSubview(self.selector)
        self.selector.snp.makeConstraints { [weak self] (make) in
            guard let view = self else { return }
            make.width.equalTo(FrameSectionMath.selectorSize.width)
            make.height.equalTo(FrameSectionMath.selectorSize.height)
            make.leading.equalTo(view.snp.leading).offset(FrameSectionMath.selectorLeftOffset)
        }
        self.selector.layoutIfNeeded()
    }
}
