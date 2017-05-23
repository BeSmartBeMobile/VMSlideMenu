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
    
    lazy var optionsCollectionView: UICollectionView = {
        let optionsLayout = UICollectionViewFlowLayout()
        optionsLayout.scrollDirection = .vertical
        optionsLayout.minimumLineSpacing = 0
        optionsLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: optionsLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = false
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.autoresizesSubviews = true
        collectionView.backgroundColor = UIColor.white
        collectionView.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    var summary: SectionCollectionViewCellSummary? {
        didSet {
            
//            guard let options = summary?.options else { return }
            
//            visibleOptions = options.map { option in
//                return
//            }
            
//            optionsCollectionView.contentOffset = CGPoint(x: summary?.viewHeight ?? 0, y: 0)
            optionsCollectionView.reloadData()
        }
    }
    
    var numberOfOptions: Int {
        return summary?.options.count ?? 0
    }
    
    var visibleOptions: [MenuOption] = []
    
    var numberOfVisibleOptions: Int {
        
        guard let baseRowsNumber = summary?.baseRowsNumber,
            numberOfOptions > 1 else {
            return numberOfOptions
        }
        
        if numberOfOptions >= baseRowsNumber {
            return baseRowsNumber
        } else {
            return numberOfOptions
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
        
        addSubview(optionsCollectionView)
        
        // Constraints
        let views: [String : Any] = ["self": self, "optionsCollectionView": optionsCollectionView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[optionsCollectionView(==self)]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[optionsCollectionView(==self)]|", options: [], metrics: nil, views: views))
    }
    
    // MARK: - Private
    
//    fileprivate var topOptionIndex: Int {
//        guard numberOfOptions > 0 else {
//            return 0
//        }
//        
//        return
//    }
    
    func heightForRow(atIndex index: Int) -> CGFloat {
        
        guard let viewHeight = summary?.viewHeight else { return 0 }
        
        guard numberOfVisibleOptions > 1 else { return self.bounds.height }
        
        return index == 0 ? self.bounds.height - CGFloat(numberOfVisibleOptions - 1) * viewHeight + viewHeight : viewHeight
    }
}

extension SectionCollectionViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard scrollView == optionsCollectionView else { return }
        
        let offsetY = scrollView.contentOffset.y
        if offsetY == 0 {
            
            print("Down")
            // Remove first
            
            // Insert last
            
        } else if offsetY == (summary?.viewHeight ?? 0) * 1 {
            
            print("Up")
            
        }
    }
}

extension SectionCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        summary?.options[indexPath.row].action()
    }
}

extension SectionCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfVisibleOptions
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.identifier, for: indexPath) as! OptionCollectionViewCell
        
        cell.summary = summary?.options[indexPath.row].summary
        
        return cell
    }
}

extension SectionCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: heightForRow(atIndex: indexPath.row))
    }
}
