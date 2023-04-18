import UIKit

extension UIColor {
	static let specialBackgroundColor = UIColor(hexString: "F5F3F4")
	static let specialPrimaryColor = UIColor(hexString: "1CC9BE")
	static let specialSecondaryColor = UIColor.systemOrange
	static let specialTextColor = UIColor(hexString: "000000")
	static let specialSeparatorColor = UIColor(hexString: "CCCCCC")
	
	
	convenience init?(hexString: String, alpha: CGFloat = 1.0) {
		var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

		if cString.hasPrefix("#") {
			cString.remove(at: cString.startIndex)
		}

		if cString.count != 6 {
			self.init()
			return nil
		}

		var rgbValue: UInt64 = 0
		Scanner(string: cString).scanHexInt64(&rgbValue)

		let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
		let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
		let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}
