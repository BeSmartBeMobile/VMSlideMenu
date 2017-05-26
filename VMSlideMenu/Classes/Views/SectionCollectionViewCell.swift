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
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    var summary: SectionCollectionViewCellSummary? {
        didSet {
            
            guard let options = summary?.options else { return }
            
            extendedOptions = options
            
            extendedOptions.append(options.first!)
            extendedOptions.insert(options.last!, at: 0)
            
            reloadOptionsViews()
        }
    }
    
    var extendedOptions: [MenuOption] = []
    
    var optionViews: [OptionView] = []
    
    var mainHeight: CGFloat {
        
        switch optionViews.count {
        case 1:
            return self.bounds.height
        case 1...Int.max:
            return self.bounds.height - CGFloat(optionViews.count - 1 - baseRowsNumber) * viewHeight
        default:
            return 0
        }
    }
    
    var fontSize: CGFloat {
        return summary?.fontSize ?? 36
    }
    
    var baseRowsNumber: Int {
        return summary?.baseRowsNumber ?? 2
    }
    
    var viewHeight: CGFloat {
        return summary?.viewHeight ?? 56
    }
    
    var firstHeightConstraint: NSLayoutConstraint?
    var lastHeightConstraint: NSLayoutConstraint?
    var mainHeightConstraint: NSLayoutConstraint?
    var viewHeightConstraint: NSLayoutConstraint?
    
    private let duration = 0.5

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
        scrollView.contentOffset = CGPoint(x: 0, y: viewHeight)
        
        // Constraints
        let views: [String : Any] = ["self": self, "scrollView": scrollView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView(==self)]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView(==self)]|", options: [], metrics: nil, views: views))
    }
    
    // MARK: - Private
    
    func reloadView() {
        scrollView.removeConstraints(scrollView.constraints)
        
        var views: [String : Any] = ["self": self, "scrollView": scrollView]
        let metrics = ["mainHeight": mainHeight, "viewHeight": viewHeight]
        var verticalConstraint = "V:|"
        
        optionViews.enumerated().forEach { index, optionView in
            
            let keyConstraint = String(format: "menuOptionView_%ld", index)
            views[keyConstraint] = optionView
            
            scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: String(format: "H:|[%@(==scrollView)]|", keyConstraint),
                                                                     options: [],
                                                                     metrics: metrics,
                                                                     views: views))
            
            switch index {
                
            case 0:
                verticalConstraint.append(String(format: "[%@]", keyConstraint))
                firstHeightConstraint = NSLayoutConstraint(item: optionView,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1,
                                                           constant: viewHeight)
                
                scrollView.addConstraint(firstHeightConstraint!)
                
            case 1:
                verticalConstraint.append(String(format: "[%@]", keyConstraint))
                mainHeightConstraint = NSLayoutConstraint(item: optionView,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1,
                                                           constant: mainHeight)
                
                scrollView.addConstraint(mainHeightConstraint!)
                
            case 2:
                verticalConstraint.append(String(format: "[%@]", keyConstraint))
                viewHeightConstraint = NSLayoutConstraint(item: optionView,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1,
                                                           constant: viewHeight)
                
                scrollView.addConstraint(viewHeightConstraint!)
                
            case extendedOptions.count - 1:
                verticalConstraint.append(String(format: "[%@]", keyConstraint))
                lastHeightConstraint = NSLayoutConstraint(item: optionView,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1,
                                                           constant: viewHeight)
                
                scrollView.addConstraint(lastHeightConstraint!)
                
            default:
                verticalConstraint.append(String(format: "[%@(==viewHeight)]", keyConstraint))
            }
        }
        
        verticalConstraint.append("|")
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalConstraint,
                                                                 options: [],
                                                                 metrics: metrics,
                                                                 views: views))
        
        scrollView.contentOffset = CGPoint(x: 0, y: viewHeight)
        scrollView.isScrollEnabled = true
    }
    
    func upAnimation() {
        
        UIView.animate(withDuration: duration, animations: {
            
            self.isUserInteractionEnabled = false
            self.scrollView.isScrollEnabled = false
            
            self.firstHeightConstraint?.constant = self.viewHeight
            self.mainHeightConstraint?.constant = self.viewHeight
            self.viewHeightConstraint?.constant = self.mainHeight
            self.lastHeightConstraint?.constant = self.viewHeight
            
            self.optionViews.enumerated().forEach { index, optionView in
                
                if index == 2 {
                    optionView.titleScale = 1.9
                    optionView.gradientAlpha = 0
                } else {
                    optionView.titleScale = 1
                    optionView.gradientAlpha = 1
                }
            }
            
            self.layoutIfNeeded()
            
        }) { finished in
            if finished {
                self.inifiniteScrollMenuOption()
                self.isUserInteractionEnabled = true
            }
        }
    }
    
    func downAnimation() {
        
        UIView.animate(withDuration: duration, animations: {
            
            self.isUserInteractionEnabled = false
            self.scrollView.isScrollEnabled = false
            
            self.firstHeightConstraint?.constant = self.mainHeight
            self.mainHeightConstraint?.constant = self.viewHeight
            self.viewHeightConstraint?.constant = self.viewHeight
            self.lastHeightConstraint?.constant = self.viewHeight
            
            self.optionViews.enumerated().forEach { index, optionView in
                
                if index == 0 {
                    optionView.titleScale = 2
                    optionView.gradientAlpha = 0
                } else if index == 1 {
                    optionView.titleScale = 0.5
                    optionView.gradientAlpha = 1
                } else {
                    optionView.titleScale = 1
                    optionView.gradientAlpha = 1
                }
            }
            
            self.layoutIfNeeded()
            
        }) { finished in
            if finished {
                self.inifiniteScrollMenuOption()
                self.isUserInteractionEnabled = true
            }
        }
    }
    
    func inifiniteScrollMenuOption() {
        
        scrollView.subviews.forEach { view in

            view.removeFromSuperview()
        }
        
        if scrollView.contentOffset.y == 0 {
            extendedOptions.removeLast()
            extendedOptions.insert(extendedOptions[extendedOptions.count-2], at: 0)
        } else {
            extendedOptions.removeFirst()
            extendedOptions.append(extendedOptions[1])
        }
        
        reloadOptionsViews()
    }
    
    func reloadOptionsViews() {
        
        optionViews.removeAll()
        extendedOptions.enumerated().forEach { index, option in
            
            let optionView = option.view
            optionView.titleLabel.font = UIFont.systemFont(ofSize: fontSize / 2)
            
            if index == 1 {
                optionView.gradientAlpha = 0
            } else {
                optionView.gradientAlpha = 1
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(optionTouchUpInside(_:)))
            
            optionView.addGestureRecognizer(tap)
            
            scrollView.addSubview(optionView)
            optionViews.append(optionView)
        }
        
        reloadView()
        textAnimation()
    }
    
    func textAnimation() {
    
        optionViews.enumerated().forEach { index, view in
            if (index == 1) {
                view.titleLabel.font = UIFont.systemFont(ofSize: fontSize)
            } else {
                view.titleLabel.font = UIFont.systemFont(ofSize: fontSize / 2)
            }
        }
    }
    
    func optionTouchUpInside(_ gestureRecognizer: UITapGestureRecognizer) {
        
        guard let optionView = gestureRecognizer.view as? OptionView,
            let index = optionViews.index(of: optionView) else { return }
        
        extendedOptions[index].action()
    }
}

extension SectionCollectionViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard scrollView == self.scrollView else { return }
        
        let offsetY = scrollView.contentOffset.y
        if offsetY == 0 {
            
            downAnimation()
            
        } else if offsetY == (viewHeight) * 2 {
            
            upAnimation()
        }
    }
}
