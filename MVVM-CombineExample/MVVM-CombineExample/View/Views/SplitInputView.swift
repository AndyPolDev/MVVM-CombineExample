import UIKit

final class SplitInputView: UIView {
	
	private let headerView: HeaderView = {
		let view = HeaderView()
		view.configure(topText: "Split", bottomText: "the total")
		return view
	}()
	
	private lazy var decrementButton: UIButton = {
		let button = buildButton(
			text: "-",
			corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
		return button
	}()
	
	private lazy var incrementButton: UIButton = {
		let button = buildButton(
			text: "+",
			corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
		return button
	}()
	
	private var quantityLabel: UILabel = {
		let label = UILabel(
			text: "1",
			font: UIFont.avenirNextBold(ofSize: 20))
		label.backgroundColor = .white
		return label
	}()
	
	private var stackView = UIStackView()
	
	init() {
		super.init(frame: .zero)
		
		setupViews()
		setConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		stackView = UIStackView(
			arrangedSubviews: [decrementButton, quantityLabel, incrementButton],
			axis: .horizontal,
			spacing: 0)
		
		addView(headerView)
		addView(stackView)
	}
	
	private func buildButton(text: String, corners: CACornerMask) -> UIButton {
		let button = UIButton(type: .custom)
		button.setTitle(text, for: .normal)
		button.titleLabel?.font = UIFont.avenirNextDemiBold(ofSize: 20) ?? .systemFont(ofSize: 20)
		button.backgroundColor = .specialPrimaryColor
		button.addRoundedCorners(corners: corners, radius: 8)
		return button
	}
}

extension SplitInputView {
	private func setConstraint() {
		stackView.snp.makeConstraints { make in
			make.top.bottom.trailing.equalToSuperview()
		}
		
		[incrementButton, decrementButton].forEach { button in
			button.snp.makeConstraints { make in
				make.width.equalTo(button.snp.height)
			}
		}
		
		headerView.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.centerY.equalTo(stackView.snp.centerY)
			make.trailing.equalTo(stackView.snp.leading).offset(-24)
			make.width.equalTo(68)
		}
	}
}
