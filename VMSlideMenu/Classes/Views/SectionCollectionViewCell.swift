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
    
    var optionViews: [OptionView] {
        return summary?.options.flatMap { $0.view } ?? []
    }
    
    var firstHeightConstraint: NSLayoutConstraint?
    var lastHeightConstraint: NSLayoutConstraint?
    var mainHeightConstraint: NSLayoutConstraint?
    var viewHeightConstraint: NSLayoutConstraint?
    
    var summary: SectionCollectionViewCellSummary? {
        didSet {
            
            
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
    
    func reloadOptionsView() {
        
        summary?.options.enumerated().forEach { option in
            let view = option.element.view
            
            if option.offset == 1 {
                // TODO: Set gradient
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(menuOptionTouchUpInside(_:)))
            view.addGestureRecognizer(tap)
            
            scrollView.addSubview(view)
        }
        
        //    _mainHeight = [self calculateHeightForOptions:_menuOptionsView];
        //
        //    [self reloadView];
        //    [self textAnimation];
    }
    
    func menuOptionTouchUpInside(_ gestureRecognizer: UITapGestureRecognizer) {
        
    }
    
//    
//    - (void)menuOptionTouchUpInside:(UITapGestureRecognizer *)gesture  {
//    
//    if ([_delegate respondsToSelector:@selector(navigateToOptionFromIndexPath:)]) {
//    
//    NSInteger indexView = [_menuOptionsView indexOfObject:gesture.view];
//    MenuOptionItem *item = [_menuOptionsExtended objectAtIndex:indexView];
//    
//    NSInteger indexOption = [_menuOptions indexOfObject:item];
//    NSIndexPath *path = [NSIndexPath indexPathForItem:indexOption inSection:0];
//    
//    [_delegate navigateToOptionFromIndexPath:path];
//    }
//    }
}

extension SectionCollectionViewCell: UIScrollViewDelegate {

}

struct SectionCollectionViewCellSummary {
    let options: [MenuOption]
}
