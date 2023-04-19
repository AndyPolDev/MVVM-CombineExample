import UIKit

final class TipInputView: UIView {
	
	private let headerView: HeaderView = {
		let view = HeaderView()
		view.configure(topText: "Choose", bottomText: "your tip")
		return view
	}()
	
	private lazy var tenPercentTipButton: UIButton = {
		let button = buildTipButton(tip: .tenPercent)
		return button
	}()
	
	private lazy var fifteenPercentTipButton: UIButton = {
		let button = buildTipButton(tip: .fifteenPercent)
		return button
	}()
	
	private lazy var twentyPercentTipButton: UIButton = {
		let button = buildTipButton(tip: .twentyPercent)
		return button
	}()
	
	private lazy var customTipButton: UIButton = {
		let button = UIButton()
		button.setTitle("Custom tip", for: .normal)
		button.titleLabel?.font = UIFont.avenirNextDemiBold(ofSize: 20)
		button.backgroundColor = .specialPrimaryColor
		button.tintColor = .white
		button.layer.cornerRadius = 8
		return button
	}()
	
	private var buttonHorizontalStackView = UIStackView()
	private var buttonVerticalStackView = UIStackView()
	
	init() {
		super.init(frame: .zero)
		
		setupViews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		buttonHorizontalStackView = UIStackView(
			arrangedSubviews: [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton],
			axis: .horizontal,
			spacing: 16)
		
		buttonHorizontalStackView.distribution = .fillEqually
		
		buttonVerticalStackView = UIStackView(
			arrangedSubviews: [buttonHorizontalStackView, customTipButton],
			axis: .vertical,
			spacing: 16)
		
		buttonVerticalStackView.distribution = .fillEqually
		
		addView(headerView)
		addView(buttonVerticalStackView)
		
	}
	
	private func buildTipButton(tip: Tip) -> UIButton {
		let button = UIButton(type: .custom)
		button.backgroundColor = UIColor.specialPrimaryColor
		button.tintColor = .white
		button.layer.cornerRadius = 8
		let text = NSMutableAttributedString(
			string: tip.stringValue,
			attributes: [
				.font: UIFont.avenirNextBold(ofSize: 20) ?? .systemFont(ofSize: 20),
				.foregroundColor: UIColor.white])
		text.addAttributes(
			[.font: UIFont.avenirNextDemiBold(ofSize: 14) ?? .systemFont(ofSize: 14)],
			range: NSMakeRange(2, 1))
		button.setAttributedTitle(text, for: .normal)
		return button
	}
}

extension TipInputView {
	private func setConstraints() {
		buttonVerticalStackView.snp.makeConstraints { make in
			make.top.bottom.trailing.equalToSuperview()
		}
		
		headerView.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.trailing.equalTo(buttonVerticalStackView.snp.leading).offset(-24)
			make.width.equalTo(68)
			make.centerY.equalTo(buttonHorizontalStackView.snp.centerY)
		}
	}
}
