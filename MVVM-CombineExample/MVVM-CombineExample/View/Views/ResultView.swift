import UIKit

final class ResultView: UIView {
	
	private let headerLabel: UILabel = {
		let label = UILabel(
			text: "Total p/person",
			font: UIFont.avenirNextDemiBold(ofSize: 18) ?? .systemFont(ofSize: 18))
		return label
	}()
	
	private let amountPerPersonLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		let text = NSMutableAttributedString(
			string: "$0",
			attributes: [.font: UIFont.avenirNextBold(ofSize: 48) ?? .systemFont(ofSize: 48)])
		text.addAttributes(
			[.font: UIFont.avenirNextBold(ofSize: 24) ?? .systemFont(ofSize: 24)],
			range: NSMakeRange(0, 1))
		label.attributedText = text
		return label
	}()
	
	private let separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = .specialSeparatorColor
		return view
	}()
	
	private let spacerView: UIView = {
		let view = UIView()
		return view
	}()
	
	private var horizontalStackView = UIStackView()
	
	private var verticalStackView = UIStackView()
	
	init() {
		super.init(frame: .zero)
		setupViews()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = 20
		self.addShadowOnView()
	}
	
	private func setupViews() {
		backgroundColor = .white
		
		horizontalStackView = UIStackView(
			arrangedSubviews: [
				AmountView(
					title: "Total bill",
					textAlligment: .left),
				UIView(),
				AmountView(
					title: "Total tip",
					textAlligment: .right)],
			axis: .horizontal)
		horizontalStackView.distribution = .fillEqually
		
		verticalStackView = UIStackView(
			arrangedSubviews: [headerLabel, amountPerPersonLabel, separatorView, spacerView, horizontalStackView],
			axis: .vertical,
			spacing: 5)
		
		addView(verticalStackView)
	}
}

extension ResultView {
	private func setConstraints() {
		
		separatorView.snp.makeConstraints { make in
			make.height.equalTo(2)
		}
		
		spacerView.snp.makeConstraints { make in
			make.height.equalTo(0)
		}
		
		verticalStackView.snp.makeConstraints { make in
			make.top.equalTo(snp.top).offset(24)
			make.leading.equalTo(snp.leading).offset(24)
			make.trailing.equalTo(snp.trailing).offset(-24)
			make.bottom.equalTo(snp.bottom).offset(-24)
		}
	}
}
