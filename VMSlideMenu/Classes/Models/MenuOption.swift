//
//  MenuItem.swift
//  Pods
//
//  Created by jmlucena on 18/5/17.
//
//

import Foundation

@objc public class MenuOption: NSObject {
    
    let name: String
    let image: UIImage
    let action: () -> ()
    
    public init(withName name: String, image: UIImage, action: @escaping () -> ()) {
        self.name = name
        self.image = image
        self.action = action
        
        super.init()
    }
}

extension MenuOption {

    var summary: OptionCollectionViewCellSummary {
        return OptionCollectionViewCellSummary(backgroundImage: self.image, title: self.name, font: UIFont.systemFont(ofSize: 50), scale: 0, gradientAlpha: 0)
    }
}
