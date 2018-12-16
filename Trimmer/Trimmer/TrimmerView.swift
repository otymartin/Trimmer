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
    
    public lazy var trimmer = UIView()
    
    private lazy var selector = TimeSelector()
    
    private lazy var generator = FramesGenerator()
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    
    public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .horizontal, topContentInset: 0, stretchToEdge: false))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.selector.delegate = self
        self.adapter.scrollViewDelegate = self.selector
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TrimmerView: TimeSelectorDelegate {
    
    public func seek(to time: CMTime) {
        
    }
    
    public func resumePlayback() {
        
    }
    
}

extension TrimmerView: FramesGeneratorDelegate {
    
    public func performUpdates() {
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}

extension TrimmerView: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.generator.section.frames as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FrameSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }

}

extension TrimmerView {
    
    public func set(_ asset: AVAsset) {
        self.generator.generate(for: asset)
    }
}

extension TrimmerView {
    
    private func configure() {
        self.configureCollectionView()
        self.addSelector()
        self.generator.delegate = self
    }
    
    private func configureCollectionView() {
        self.adapter.dataSource = self
        self.collectionView.bounces = true
        self.collectionView.frame = self.bounds
        self.collectionView.backgroundColor = .clear
        self.adapter.collectionView = self.collectionView
        self.collectionView.alwaysBounceHorizontal = true
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: FrameSectionMath.collectionViewContentOffset, bottom: 0, right: FrameSectionMath.frameSize.width)
        self.addSubview(self.collectionView)
    }
    
    private func addSelector() {
        self.trimmer.layer.cornerRadius = 6
        self.trimmer.backgroundColor = .clear
        self.trimmer.isUserInteractionEnabled = false
        self.trimmer.layer.borderColor = UIColor.white.cgColor
        self.trimmer.layer.borderWidth = FrameSectionMath.selectorBorderWidth
        self.addSubview(self.trimmer)
        self.trimmer.snp.makeConstraints { [weak self] (make) in
            guard let view = self else { return }
            make.width.equalTo(FrameSectionMath.selectorSize.width)
            make.height.equalTo(FrameSectionMath.selectorSize.height)
            make.leading.equalTo(view.snp.leading).offset(FrameSectionMath.selectorLeftOffset)
        }
        self.trimmer.layoutIfNeeded()
    }
}
