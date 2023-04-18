import UIKit

final class LogoView: UIView {
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "icCalculatorBW")
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let topLabel: UILabel = {
		let label = UILabel()
		let text = NSMutableAttributedString(
		string: "Mr. TIP",
		attributes: [.font: UIFont.avenirNextDemiBold(ofSize: 16) ?? .systemFont(ofSize: 16)])
		text.addAttributes([.font: UIFont.avenirNextBold(ofSize: 24) ?? .systemFont(ofSize: 24)], range: NSMakeRange(4, 3))
		label.attributedText = text
		return label
	}()
	
	private let bottomLabel = UILabel(
		text: "Calculator",
		font: UIFont.avenirNextDemiBold(ofSize: 20),
		textAligment: .left)
	
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
	
	private func setupViews() {
		backgroundColor = .clear
		
		verticalStackView = UIStackView(
			arrangedSubviews: [topLabel, bottomLabel],
			axis: .vertical,
			spacing: -4)
		
		horizontalStackView = UIStackView(
			arrangedSubviews: [imageView, verticalStackView],
			axis: .horizontal,
			spacing: 8)
		
		addView(horizontalStackView)
	}
}

extension LogoView{
	private func setConstraints() {
		imageView.snp.makeConstraints { make in
			make.height.equalTo(imageView.snp.width)
		}
		
		horizontalStackView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.centerX.equalToSuperview()
		}
	}
}
