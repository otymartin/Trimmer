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
    
    public var asset: AVAsset? {
        didSet {
            self.setAsset()
        }
    }
    
    private var frames: [Frame] =  []
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .horizontal, topContentInset: 0, stretchToEdge: false))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TrimmerView: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.frames as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FrameSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }

}

extension TrimmerView {
    
    public func setAsset() {
        guard let asset = self.asset else { return }
        let size = CGSize(width: abs(60 * 0.70), height: 60)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let scaledSize = CGSize(width: size.width * UIScreen.main.scale, height: size.height * UIScreen.main.scale)
        generator.maximumSize = scaledSize
        let numberOfThumbnails = Int(ceil(asset.duration.seconds))
        var times = [NSValue]()
        for index in 0..<numberOfThumbnails {
            let time = CMTime(seconds: Float64(index), preferredTimescale: 600)
            let value = NSValue(time: time)
            times.append(value)
        }
        generator.generateCGImagesAsynchronously(forTimes: times) { (_, image, _, result, error) in
            <#code#>
        }
    }
}

extension TrimmerView {
    
    private func configure() {
        self.configureCollectionView()
    }
    
    private func configureCollectionView() {
        self.adapter.dataSource = self
        self.collectionView.frame = self.bounds
        self.collectionView.backgroundColor = .yellow
        self.adapter.collectionView = self.collectionView
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(self.collectionView)
    }
}
