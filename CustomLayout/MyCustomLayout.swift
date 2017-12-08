//
//  MyCustomLayout.swift
//  CustomLayout
//
//  Created by Colick on 2017/11/27.
//  Copyright © 2017年 The Big Nerd. All rights reserved.
//

import UIKit

//constant
let INSET_TOP: CGFloat = 10
let INSET_LEFT: CGFloat = 10
let INSET_BOTTOM: CGFloat = 10
let INSET_RIGHT: CGFloat = 10

let ITEM_WIDTH: CGFloat = 10
let ITEM_HEIGHT: CGFloat = 10

class MyCustomLayout: UICollectionViewLayout {
    var customDataSource: MyCustomProtocol?
    
    var layoutInformation = [String: [IndexPath: MyCustomAttributes]]()
    var maxNumRows = 0
    
    var insets: UIEdgeInsets
    
    
    override init() {
        self.insets = UIEdgeInsetsMake(INSET_TOP, INSET_LEFT, INSET_BOTTOM, INSET_RIGHT)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.insets = UIEdgeInsetsMake(INSET_TOP, INSET_LEFT, INSET_BOTTOM, INSET_RIGHT)
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        var layoutInformation = [String: [IndexPath: MyCustomAttributes]]()
        var cellInformation = [IndexPath: MyCustomAttributes]()
        var indexPath: IndexPath
        let numSections = self.collectionView!.numberOfSections
        
        for section in 0..<numSections {
            let numItems = self.collectionView!.numberOfItems(inSection: section)
            for item in 0..<numItems {
                indexPath = IndexPath(item: item, section: section)
                let attributes = self.attributesWithChildren(at: indexPath)
                cellInformation[indexPath] = attributes
            }
        }
        
        for section in stride(from: numSections - 1, through: 0, by: -1) {
            let numItems = self.collectionView!.numberOfItems(inSection: section)
            var totalHeight = 0
            for item in 0..<numItems {
                indexPath = IndexPath(item: item, section: section)
                let attributes = cellInformation[indexPath]
                attributes?.frame = self.frameForCell(at: indexPath, with: totalHeight)
                self.adjustFramesOfChildrenAndConnectorsForClass(at: indexPath)
                cellInformation[indexPath] = attributes
                totalHeight += self.customDataSource!.numRowsForClassAndChildren(at: indexPath)
                
            }
            if section == 0 {
                self.maxNumRows = totalHeight
            }
        }
        layoutInformation["MyCellKind"] = cellInformation
        self.layoutInformation = layoutInformation
    }
    
    override var collectionViewContentSize: CGSize {
        let width = CGFloat(self.collectionView!.numberOfSections) * (ITEM_WIDTH + self.insets.left + self.insets.right)
        let height = CGFloat(self.maxNumRows) * (ITEM_HEIGHT + insets.top + insets.bottom)
        return CGSize(width: width, height: height)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var myAttributes = [MyCustomAttributes]()
        for (_, value) in layoutInformation {
            for (_, attributes) in value {
                if rect.contains(attributes.frame) {
                    myAttributes.append(attributes)
                }
            }
        }
        return myAttributes
    }
    
    func attributesWithChildren(at indexPath: IndexPath) -> MyCustomAttributes {
        return MyCustomAttributes()
    }
    
    func frameForCell(at indexPath: IndexPath, with height: Int) -> CGRect {
        return CGRect()
    }
    
    func adjustFramesOfChildrenAndConnectorsForClass(at indexPath: IndexPath) {
        
    }
}



protocol MyCustomProtocol {
    func numRowsForClassAndChildren(at indexPath: IndexPath) -> Int
}
