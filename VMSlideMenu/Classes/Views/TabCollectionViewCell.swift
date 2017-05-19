//
//  TabCollectionViewCell.swift
//  Pods
//
//  Created by Jorge Miguel Lucena Pino on 19/05/2017.
//
//

import UIKit

class TabCollectionViewCell: UICollectionViewCell {
    
    // MARK: Static properties
    
    static let identifier = "TabCollectionViewCell"
    
    // MARK: Properties
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var summary: TabCollectionViewCellSummary? {
        didSet {
            imageView.image = summary?.image
        }
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    func initializeView() {
        
        addSubview(imageView)
        
        // Constraints
        // Constraints
        let views = ["imageView": imageView]
        let metrics = ["margin": 10, "viewHeight": 3]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[imageView]-margin-|", options: [], metrics: metrics, views: views))
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[optionsCollectionView]|", options: [], metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-margin-[imageView]-(>=margin)-|", options: [], metrics: metrics, views: views))
 
    }
    
}

struct TabCollectionViewCellSummary {
    let image: UIImage
}
