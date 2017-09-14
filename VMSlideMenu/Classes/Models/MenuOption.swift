import Foundation

@objc public class MenuOption: NSObject {
    let name: String
    let image: UIImage
    let action: () -> Void

    public init(withName name: String, image: UIImage, action: @escaping () -> Void) {
        self.name = name
        self.image = image
        self.action = action
        super.init()
    }
}

extension MenuOption {
    var view: OptionView {
        let view = OptionView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.summary = OptionViewSummary(backgroundImage: image,
                                         title: name)
        return view
    }
}
