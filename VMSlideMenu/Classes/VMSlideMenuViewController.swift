
import Foundation

@objc open class VMSlideMenuViewController: UIViewController {
    
    // MARK: Properties
    
    public var tabs: [MenuTab] = [] {
        didSet {
            tabsCollectionView.reloadData()
            sectionsCollectionView.reloadData()
            if !tabs.isEmpty { tabsCollectionView.selectItem(at: IndexPath(item: 0, section:0), animated: true, scrollPosition: .left) }
        }
    }
    
    public var backgroundColor: UIColor? {
        didSet {
            tabsCollectionView.backgroundColor = backgroundColor
        }
    }
    
    lazy var tabsCollectionView: UICollectionView = {
        let tabLayout = UICollectionViewFlowLayout()
        tabLayout.scrollDirection = .horizontal
        tabLayout.minimumLineSpacing = 0
        tabLayout.minimumInteritemSpacing = 0
        
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
        collectionView.allowsMultipleSelection = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.alwaysBounceVertical = false
        collectionView.autoresizesSubviews = true
        collectionView.backgroundColor = self.backgroundColor
        collectionView.register(TabCollectionViewCell.self, forCellWithReuseIdentifier: TabCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    lazy var sectionsCollectionView: UICollectionView = {
        let sectionsLayout = UICollectionViewFlowLayout()
        sectionsLayout.scrollDirection = .horizontal
        sectionsLayout.minimumLineSpacing = 0
        sectionsLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: sectionsLayout)
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
        collectionView.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    public var height: CGFloat = 44
    
    
    // MARK: - Initialization
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public init(withTabs tabs: [MenuTab], andBackgroundColor backgroundColor: UIColor? = nil) {
        self.tabs = tabs
        self.backgroundColor = backgroundColor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        configureView()
    }
    
    
    func configureView() {
        
        navigationController?.hidesBarsOnSwipe = false
        
        view.addSubview(tabsCollectionView)
        view.addSubview(sectionsCollectionView)
        
        if !tabs.isEmpty { tabsCollectionView.selectItem(at: IndexPath(item: 0, section:0), animated: true, scrollPosition: .left) }
        
        // Constraints
        let views = ["tabsCollectionView": tabsCollectionView, "sectionsCollectionView": sectionsCollectionView]
        let metrics = ["margin": 10, "menuHeight": height]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tabsCollectionView]|", options: [], metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[sectionsCollectionView]|", options: [], metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tabsCollectionView(==menuHeight)][sectionsCollectionView]|", options: [], metrics: metrics, views: views))
    }
}

extension VMSlideMenuViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == tabsCollectionView {
            
            guard let selectedTabIndexPath = tabsCollectionView.indexPathsForSelectedItems?.first else { return }
            sectionsCollectionView.scrollToItem(at: selectedTabIndexPath, at: .left, animated: true)
            tabsCollectionView.isUserInteractionEnabled = false
        }
    }
}

extension VMSlideMenuViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tabs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tabsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.identifier, for: indexPath) as! TabCollectionViewCell
            
            cell.summary = tabs[indexPath.row].summary
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as! SectionCollectionViewCell
            
            cell.summary = SectionCollectionViewCellSummary(options: tabs[indexPath.row].options)
            
            return cell
        }
    }
}

extension VMSlideMenuViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabsCollectionView {
            
            let width = collectionView.bounds.width / CGFloat(tabs.count)
            
            return CGSize(width: width, height: height)
            
        } else {
            
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
    }
}

extension VMSlideMenuViewController: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard scrollView == sectionsCollectionView else { return }
        
        let pageWidth = scrollView.bounds.width
        let x = scrollView.contentOffset.x
        let page = Int(floor((x - (pageWidth / 2)) / pageWidth) + 1)
        
        let indexPath = IndexPath(item: page, section: 0)
        
        tabsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        tabsCollectionView.isUserInteractionEnabled = true
    }
}
