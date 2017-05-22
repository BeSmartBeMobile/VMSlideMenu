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
    
//    lazy var gradientView: GradientView = { // TODO: Gradient view
//        
//        
//    }()
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.shadowColor = UIColor.black // TODO: Customize?
        label.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 4
        label.layer.masksToBounds = false
        label.layer.shouldRasterize = true
        
        
        return label
    }()
    
    var summary: OptionViewSummary? {
        didSet {
            guard let summary = summary else { return }
            
            self.backgroundImageView.image = summary.backgroundImage
            self.titleLabel.text = summary.title
            self.titleLabel.font = summary.font
//            self.titleLabel.transform = titleLabel.transform.scaledBy(x: summary.scale, y: summary.scale)
            // TODO: set alpha
        }
    }
    
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
        addSubview(titleLabel)
        
        // Constraints
        let views: [String : Any] = ["titleLabel": titleLabel, "backgroundImageView": backgroundImageView]
        let metrics = ["margin": 20]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundImageView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundImageView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[titleLabel]-margin-|", options: [], metrics: metrics, views: views))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }

}

struct OptionViewSummary {
    let backgroundImage: UIImage
    let title: String
    let font: UIFont?
    let scale: CGFloat
    let gradientAlpha: CGFloat
}
