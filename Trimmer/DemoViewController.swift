//
//  DemoViewController.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit
import AVFoundation

class DemoViewController: UIViewController {
    
    private var trimmer: TrimmerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        guard let path = Bundle.main.path(forResource: "uoit", ofType:"mp4") else {
            print("Video Not Found")
            return
        }
        let asset = AVAsset(url: URL(fileURLWithPath: path))
        self.trimmer.set(asset)
        
    }
}

extension DemoViewController {
    
    private func configure() {
        self.view.backgroundColor = .white
        self.trimmer = TrimmerView(frame: CGRect(x: 0, y: self.view.bounds.height - 200, width: FrameSectionMath.collectionViewSize.width, height: FrameSectionMath.collectionViewSize.height))
        self.view.addSubview(self.trimmer)
    }
}

