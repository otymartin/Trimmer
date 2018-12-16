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
    
    public weak var delegate: TrimmerViewDelegate?
    
    private lazy var leftDimView = TrimmerDimView()
    
    private lazy var rightDimView = TrimmerDimView()
    
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

extension TrimmerView: TrimmerViewDelegate {
    
    public func trimmer(_ isTrimming: Bool) {
        self.delegate?.trimmer(isTrimming)
    }
    
    public func seek(to time: CMTime) {
        self.delegate?.seek(to: time)
    }
    
    public func resumePlayback() {
        self.delegate?.resumePlayback()
    }
    
    public func dimView(leftOffset: CGFloat, rightOffset: CGFloat) {
        self.leftDimView.snp.updateConstraints { (make) in
            make.leading.equalTo(trimmer.snp.leading).offset(leftOffset)
        }
        self.rightDimView.snp.updateConstraints { (make) in
            make.trailing.equalTo(trimmer.snp.trailing).offset(rightOffset)
        }
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
        self.selector.asset = asset
    }
}

extension TrimmerView {
    
    private func configure() {
        self.configureCollectionView()
        self.addTrimmer()
        self.addDimViews()
        self.generator.delegate = self
        self.selector.delegate = self
        self.adapter.scrollViewDelegate = self.selector
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
    
    private func addTrimmer() {
        self.trimmer.addShadow(contentOffset: .zero, radius: 3, color: .black, opacity: 0.1)
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
    
    private func addDimViews() {
        self.leftDimView.position = .first
        self.leftDimView.roundCorners([.topLeft, .bottomLeft], radius: 6)
        self.leftDimView.addShadow(contentOffset: .zero, radius: 3, color: .black, opacity: 0.1)
        self.leftDimView.isUserInteractionEnabled = false
        self.leftDimView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addSubview(self.leftDimView)
        self.leftDimView.snp.makeConstraints { [weak self] (make) in
            guard let view = self else { return }
            make.centerY.equalTo(view.snp.centerY)
            make.trailing.equalTo(trimmer.snp.leading)
            make.leading.equalTo(trimmer.snp.leading)
            make.height.equalTo(FrameSectionMath.frameSize.height)
        }
        self.leftDimView.layoutIfNeeded()
        
        self.rightDimView.position = .last
        self.rightDimView.roundCorners([.topRight, .bottomRight], radius: 6)
        self.rightDimView.addShadow(contentOffset: .zero, radius: 3, color: .black, opacity: 0.1)
        self.rightDimView.isUserInteractionEnabled = false
        self.rightDimView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addSubview(self.rightDimView)
        self.rightDimView.snp.makeConstraints { [weak self] (make) in
            guard let view = self else { return }
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(trimmer.snp.trailing)
            make.trailing.equalTo(trimmer.snp.trailing).offset(FrameSectionMath.frameSize.width)
            make.height.equalTo(FrameSectionMath.frameSize.height)
        }
        self.rightDimView.layoutIfNeeded()
    }
}
