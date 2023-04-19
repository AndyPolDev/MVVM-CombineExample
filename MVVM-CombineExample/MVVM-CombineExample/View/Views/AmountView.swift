import UIKit

final class AmountView: UIView {
	
	private let title: String
	private let textAlligment: NSTextAlignment
	
	private lazy var titleLabel = UILabel(
		text: title,
		font: UIFont.avenirNextRegular(ofSize: 18) ?? .systemFont(ofSize: 18),
		textColor: .specialTextColor,
		textAligment: textAlligment
	)
	
	private lazy var amountLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = textAlligment
		label.textColor = .specialPrimaryColor
		let text = NSMutableAttributedString(
			string: "$0",
			attributes: [.font: UIFont.avenirNextBold(ofSize: 24) ?? .systemFont(ofSize: 24)])
		text.addAttributes(
			[.font: UIFont.avenirNextBold(ofSize: 16) ?? .systemFont(ofSize: 16)],
			range: NSMakeRange(0, 1))
		label.attributedText = text
		return label
	}()
	
	private var verticalStackView = UIStackView()
	
	init(title: String, textAlligment: NSTextAlignment) {
		self.title = title
		self.textAlligment = textAlligment
		super.init(frame: .zero)
		
		setupViews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		verticalStackView = UIStackView(
			arrangedSubviews: [titleLabel, amountLabel],
			axis: .vertical)
		
		addView(verticalStackView)
	}
}

extension AmountView {
	private func setConstraints() {
		verticalStackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
