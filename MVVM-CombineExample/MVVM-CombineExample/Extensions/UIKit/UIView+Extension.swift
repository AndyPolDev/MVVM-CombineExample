import UIKit

extension UIView {
	func addView(_ view: UIView) {
		self.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
	}
	
	func addShadowOnView() {
		layer.shadowColor = UIColor.gray.cgColor
		layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
		layer.shadowOpacity = 0.1
		layer.shadowRadius = 12.0
	}
	
	func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
		layer.cornerRadius = radius
		layer.maskedCorners = [corners]
	}
}
