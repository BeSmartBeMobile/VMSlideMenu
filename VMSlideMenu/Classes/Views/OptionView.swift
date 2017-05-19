//
//  OptionView.swift
//  Pods
//
//  Created by Jorge Miguel Lucena Pino on 19/05/2017.
//
//

import UIKit

class OptionView: UIView {

    lazy var backgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
//    lazy var gradientView: GradientView = {
//        
//        
//    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    func initializeView() {
        
        addSubview(backgroundImageView)
        
        // Constraints
        let views: [String : Any] = ["self": self, "backgroundImageView": backgroundImageView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundImageView(==self)]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundImageView(==self)]|", options: [], metrics: nil, views: views))
    }

}
