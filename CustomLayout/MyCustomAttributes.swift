//
//  MyCustomAttributes.swift
//  CustomLayout
//
//  Created by Colick on 2017/11/27.
//  Copyright © 2017年 The Big Nerd. All rights reserved.
//

import UIKit

class MyCustomAttributes: UICollectionViewLayoutAttributes {
    var children = NSArray()
    
    override func isEqual(_ object: Any?) -> Bool {
        let otherAttributes = object as! MyCustomAttributes
        if self.children.isEqual(otherAttributes.children) {
            return super.isEqual(object)
        }
        return false
    }
    
    
}
