//
//  SectionCollectionViewCell.swift
//  Pods
//
//  Created by Jorge Miguel Lucena Pino on 19/05/2017.
//
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    
    // MARK: Static properties
    
    static let identifier = "SectionCollectionViewCell"
    
    // MARK: Properties
    
    let viewHeight: CGFloat = 56
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.contentOffset = CGPoint(x: 0, y: self.viewHeight)
        
        return scrollView
    }()
    
    lazy var optionViews: [OptionView] = []
    
    var firstHeightConstraint: NSLayoutConstraint?
    var lastHeightConstraint: NSLayoutConstraint?
    var mainHeightConstraint: NSLayoutConstraint?
    var viewHeightConstraint: NSLayoutConstraint?
    
    var summary: SectionCollectionViewCellSummary? {
        didSet {
            optionViews = summary?.options.flatMap { $0.view } ?? []
            
            guard let view = optionViews.first else {
                return
            }
            
            scrollView.addSubview(view)
            
            
            let views: [String : Any] = ["view": view, "scrollView": scrollView]
            
            scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view(==scrollView)]|", options: [], metrics: nil, views: views))
            scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view(==scrollView)]|", options: [], metrics: nil, views: views))
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
        
        addSubview(scrollView)
        
        // Constraints
        let views: [String : Any] = ["self": self, "scrollView": scrollView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView(==self)]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView(==self)]|", options: [], metrics: nil, views: views))
    }
}

extension SectionCollectionViewCell: UIScrollViewDelegate {

}

struct SectionCollectionViewCellSummary {
    let options: [MenuOption]
}
