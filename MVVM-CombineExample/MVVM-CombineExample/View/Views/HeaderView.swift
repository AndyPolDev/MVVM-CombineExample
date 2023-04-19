import UIKit

final class HeaderView: UIView {
	
	private let topLabel = UILabel(
		text: nil,
		font: UIFont.avenirNextBold(ofSize: 18))
	
	private let bottomLabel = UILabel(
		text: nil,
		font: UIFont.avenirNextRegular(ofSize: 16))
	
	private let topSpacerView = UIView()
	private let bottomSpacerView = UIView()
	
	private var verticalStackView = UIStackView()
	
	init() {
		super.init(frame: .zero)
		
		setupViews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		verticalStackView = UIStackView(
			arrangedSubviews: [topSpacerView, topLabel, bottomLabel, bottomSpacerView],
			axis: .vertical,
			spacing: -4)
		verticalStackView.alignment = .leading
		
		addView(verticalStackView)
	}
	
	func configure(topText: String, bottomText: String) {
		topLabel.text = topText
		bottomLabel.text = bottomText
	}
}

extension HeaderView {
	private func setConstraints() {
		verticalStackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		topSpacerView.snp.makeConstraints { make in
			make.height.equalTo(bottomSpacerView)
		}
	}
}
