import UIKit

extension UILabel {
	convenience init(
		text: String?,
		font: UIFont?,
		backgroundColor: UIColor = .clear,
		textColor: UIColor? = .specialTextColor,
		textAligment: NSTextAlignment = .center)
	{
		self.init()
		self.text = text
		self.font = font
		self.backgroundColor = backgroundColor
		self.textColor = textColor
		self.textAlignment = textAligment
		self.adjustsFontSizeToFitWidth = true
	}
}
