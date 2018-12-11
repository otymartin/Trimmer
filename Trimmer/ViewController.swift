//
//  ViewController.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class ViewController: UIViewController {
    
    let trimmer = TrimmerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTrimmer()
    }
    
    private func addTrimmer() {
        self.view.addSubview(self.trimmer)
        self.trimmer.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        self.trimmer.layoutIfNeeded()
        
        guard let path = Bundle.main.path(forResource: "dog", ofType:"mov") else {
            print("Video Not Found")
            return
        }
        
        let asset = AVAsset(url: URL(fileURLWithPath: path))
        
        self.trimmer.asset = asset
    }

}

