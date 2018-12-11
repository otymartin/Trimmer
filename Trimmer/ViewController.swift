//
//  ViewController.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-11.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit
import SnapKit
import PryntTrimmerView

class ViewController: UIViewController {
    
    let trimmer = TrimmerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTrimmer()
    }
    
    private func addTrimmer() {
        self.view.addSubview(self.trimmer)
        self.trimmer.snp.makeConstraints { (make) in
            make.height.equalTo(70)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }


}

