import UIKit

final class TipInputView: UIView {

	init() {
		super.init(frame: .zero)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		backgroundColor = .blue
	}
}
