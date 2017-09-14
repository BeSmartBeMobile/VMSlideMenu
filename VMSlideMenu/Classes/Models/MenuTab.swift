import Foundation

@objc public class MenuTab: NSObject {
    let icon: UIImage
    let selectionColor: UIColor?
    let options: [MenuOption]

    public init(icon: UIImage, selectionColor: UIColor? = nil, options: [MenuOption]) {
        self.icon = icon
        self.selectionColor = selectionColor
        self.options = options
        super.init()
    }
}

extension MenuTab {
    var summary: TabCollectionViewCellSummary {
        return TabCollectionViewCellSummary(icon: icon,
                                            selectionColor: selectionColor)
    }
}
