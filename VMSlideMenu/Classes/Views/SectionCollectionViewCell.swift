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
        let optionsLayout = SlideLayout()
        optionsLayout.scrollDirection = .vertical
        optionsLayout.minimumLineSpacing = 0
        optionsLayout.minimumInteritemSpacing = 0
        optionsLayout.itemSize = CGSize(width: 375, height: 156)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: optionsLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        
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
            
            guard let options = summary?.options else { return }
            
            
            extendedOptions = options
            
            if numberOfOptions > 1 {
                extendedOptions.append(options.first!)
                extendedOptions.insert(options.last!, at: 0)
                optionsCollectionView.reloadData()
                optionsCollectionView.contentOffset = CGPoint(x: 0, y: heightForRow(atIndex: 0))
            } else {
                optionsCollectionView.reloadData()
            }
        }
    }
    
    var numberOfOptions: Int {
        return summary?.options.count ?? 0
    }
    
    var extendedOptions: [MenuOption] = []
    
    var index: Int = 1 {
        didSet {
            
        }
    }
    
    var numberOfVisibleOptions: Int {
        
//        let sectionViewHeight = self.bounds.height
//        
//        guard let optionViewHeight = summary?.viewHeight,
//            sectionViewHeight > optionViewHeight else { return 0 }
//        
//        let max = sectionViewHeight / optionViewHeight
        
        guard let baseRowsNumber = summary?.baseRowsNumber,
            numberOfOptions > 1 else {
            return numberOfOptions
        }
        
        if numberOfOptions >= baseRowsNumber + 1 {
            return baseRowsNumber + 1
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
    
    func heightForRow(atIndex index: Int) -> CGFloat {
        
        guard let viewHeight = summary?.viewHeight else { return 0 }
        
//        guard numberOfVisibleOptions > 1 else { return self.bounds.height }
//        
//        return index == 1 ? self.bounds.height - CGFloat(numberOfVisibleOptions - 1) * viewHeight : viewHeight
        
        return viewHeight
    }
}

extension SectionCollectionViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard scrollView == optionsCollectionView else { return }
        
        let offsetY = scrollView.contentOffset.y
        if offsetY == 0 {
            
            print("Down")
            // Remove first
//            extendedOptions.shifted()
            // Insert last
            
        } else if offsetY == (summary?.viewHeight ?? 0) * 1 {
            
            print("Up")
//            extendedOptions.shifted(withDistance: -1)
            
        }
    }
}

extension SectionCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        extendedOptions[indexPath.row].action()
        optionsCollectionView.contentOffset = CGPoint(x: 0, y: heightForRow(atIndex: 0))
    }
}

extension SectionCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return extendedOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.identifier, for: indexPath) as! OptionCollectionViewCell
        
        cell.summary = extendedOptions[indexPath.row].summary
        
        return cell
    }
}

//extension SectionCollectionViewCell: UICollectionViewDelegateFlowLayout {
//    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print("Size \(heightForRow(atIndex: indexPath.row))")
//        return CGSize(width: collectionView.bounds.width, height: heightForRow(atIndex: indexPath.row))
//    }
//}
