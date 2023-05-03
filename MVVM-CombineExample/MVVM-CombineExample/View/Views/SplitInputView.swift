import UIKit
import Combine
import CombineCocoa

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
		button.tapPublisher.flatMap { [unowned self] _ in
			Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
		}.assign(to: \.value, on: splitSubject)
			.store(in: &cancellables)
		return button
	}()
	
	private lazy var incrementButton: UIButton = {
		let button = buildButton(
			text: "+",
			corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
		button.tapPublisher.flatMap { [unowned self] _ in
			Just(splitSubject.value + 1)
		}.assign(to: \.value, on: splitSubject)
			.store(in: &cancellables)
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
	
	private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
	var valuePublisher: AnyPublisher<Int, Never> {
		return splitSubject.removeDuplicates().eraseToAnyPublisher()
	}
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		super.init(frame: .zero)
		
		setupViews()
		setConstraint()
		observe()
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
	
	private func observe() {
		splitSubject.sink { [unowned self] quantity in
			quantityLabel.text = quantity.stringValue
		}.store(in: &cancellables)
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
