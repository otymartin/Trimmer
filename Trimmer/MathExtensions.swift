//
//  MathExtensions.swift
//  Trimmer
//
//  Created by Martin Otyeka on 2018-12-15.
//  Copyright © 2018 Capsule. All rights reserved.
//

import UIKit
import Foundation

public extension CGFloat {
    
    public func add(_ number: CGFloat) -> CGFloat {
        return self + number
    }
    
    public func subtract(_ number: CGFloat) -> CGFloat {
        return self - number
    }
    
    public func multiplied(by number: CGFloat) -> CGFloat {
        return self * number
    }
    
    public func divided(by number: CGFloat) -> CGFloat {
        return self / number
    }
    
    public var percent: CGFloat {
        return self.divided(by: 100)
    }
}
