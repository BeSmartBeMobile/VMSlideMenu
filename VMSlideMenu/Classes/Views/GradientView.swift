import Foundation

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }

    func initializeView() {
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let colorComponents: [CGFloat] = [0.0, 0.0, 0.0, 0.6, 0.0, 0.0, 0.0, 0.1]
        let locations: [CGFloat] = [1.0, 0.0]
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let translation = CGPoint(x: center.x, y: center.y)
        let radius = sqrt(translation.x * translation.x + translation.y * translation.y)

        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        guard let gradient = CGGradient(colorSpace: colorSpace,
                                        colorComponents: colorComponents,
                                        locations: locations,
                                        count: 2) else {
            return
        }

        context?.drawRadialGradient(gradient,
                                    startCenter: center,
                                    startRadius: 0,
                                    endCenter: center,
                                    endRadius: radius,
                                    options: [])
        context?.restoreGState()
    }
}
