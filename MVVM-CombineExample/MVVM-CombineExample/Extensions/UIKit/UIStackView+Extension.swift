import UIKit

extension UIStackView {
	convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
		self.init(arrangedSubviews: arrangedSubviews)
		self.axis = axis
		self.spacing = spacing
	}
	
	convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis) {
		self.init(arrangedSubviews: arrangedSubviews)
		self.axis = axis
	}
}
