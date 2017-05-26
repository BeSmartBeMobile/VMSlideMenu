//
//  Array+Shift.swift
//  Pods
//
//  Created by jmlucena on 24/5/17.
//
//

import Foundation

extension Array {
    
    func shift(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 ?
            self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
            self.index(endIndex, offsetBy: distance, limitedBy: startIndex)
        
        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
    
    mutating func shifted(withDistance distance: Int = 1) {
        self = shift(withDistance: distance)
    }
}
