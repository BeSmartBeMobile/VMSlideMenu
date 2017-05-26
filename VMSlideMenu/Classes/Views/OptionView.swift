//
//  OptionView.swift
//  Pods
//
//  Created by Jorge Miguel Lucena Pino on 19/05/2017.
//
//

import UIKit

class OptionView: UIView {
    
    // MARK: Properties

    lazy var backgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var gradientView: GradientView = {
        let gradientView = GradientView(frame: .zero)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        return gradientView
    }()
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 4
        label.layer.masksToBounds = false
        label.layer.shouldRasterize = true
        
        return label
    }()
    
    var titleScale: CGFloat = 1 {
        didSet {
            titleLabel.transform = titleLabel.transform.scaledBy(x: titleScale, y: titleScale)
        }
    }
    
    var gradientAlpha: CGFloat = 1 {
        didSet {
            gradientView.alpha = gradientAlpha
        }
    }
    
    var summary: OptionViewSummary? {
        didSet {
            guard let summary = summary else { return }
            
            self.backgroundImageView.image = summary.backgroundImage
            self.titleLabel.text = summary.title
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
        addSubview(gradientView)
        addSubview(titleLabel)
        
        // Constraints
        let views: [String : Any] = ["titleLabel": titleLabel, "backgroundImageView": backgroundImageView, "gradientView": gradientView]
        let metrics = ["margin": 20]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundImageView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundImageView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[gradientView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[gradientView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[titleLabel]-margin-|", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]|", options: [], metrics: metrics, views: views))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }

}
