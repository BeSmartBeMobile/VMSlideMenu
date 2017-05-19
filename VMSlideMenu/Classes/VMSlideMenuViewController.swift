
import Foundation

@objc public class VMSlideMenuViewController: UIViewController {
    
    // MARK: Properties
    
    let tabs: [MenuTab]
    
    var backgroundColor: UIColor {
        return UIColor.blue // TODO
    }
    
    lazy var tabsCollectionView: UICollectionView = {
        let tabLayout = UICollectionViewFlowLayout()
        tabLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: tabLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.allowsSelection = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.alwaysBounceVertical = false
        collectionView.autoresizesSubviews = true
        collectionView.backgroundColor = self.backgroundColor
//        collectionView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)

        return collectionView
    }()
    
    lazy var optionsCollectionView: UICollectionView = {
        let optionsLayout = UICollectionViewFlowLayout()
        optionsLayout.scrollDirection = .horizontal
        
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
        collectionView.autoresizesSubviews = true
        collectionView.backgroundColor = UIColor.white
//        collectionView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        
        return collectionView
    }()
 
    public init(withTabs tabs: [MenuTab]) {
        self.tabs = tabs
 
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        configureView()
    }
    
    
    func configureView() {
        
        navigationController?.hidesBarsOnSwipe = false
    
        view.addSubview(tabsCollectionView)
        view.addSubview(optionsCollectionView)
        
        // Constraints
        let views = ["tabsCollectionView": tabsCollectionView, "optionsCollectionView": optionsCollectionView]
        let metrics = ["margin": 10, "menuHeight": 44]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tabsCollectionView]|", options: [], metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[optionsCollectionView]|", options: [], metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tabsCollectionView(==menuHeight)][optionsCollectionView]|", options: [], metrics: metrics, views: views))
    }
}

extension VMSlideMenuViewController: UICollectionViewDelegate {
    
}

extension VMSlideMenuViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tabs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
}
