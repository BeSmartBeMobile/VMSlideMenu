//
//  MenuTab.swift
//  Pods
//
//  Created by jmlucena on 18/5/17.
//
//

import Foundation

@objc public class MenuTab: NSObject {
    let icon: UIImage
    let options: [MenuOption]
    
    public init(icon: UIImage, options: [MenuOption]) {
        self.icon = icon
        self.options = options
        
        super.init()
    }
}

extension MenuTab {
    
    var summary: TabCollectionViewCellSummary {
        return TabCollectionViewCellSummary(image: self.icon)
    }
}
