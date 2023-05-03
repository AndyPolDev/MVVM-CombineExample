import UIKit
import Combine
import CombineCocoa

final class TipInputView: UIView {
	
	private let headerView: HeaderView = {
		let view = HeaderView()
		view.configure(topText: "Choose", bottomText: "your tip")
		return view
	}()
	
	private lazy var tenPercentTipButton: UIButton = {
		let button = buildTipButton(tip: .tenPercent)
		button.tapPublisher.flatMap({
			Just(Tip.tenPercent)
		}).assign(to: \.value, on: tipSubject)
			.store(in: &cancellables)
		return button
	}()
	
	private lazy var fifteenPercentTipButton: UIButton = {
		let button = buildTipButton(tip: .fifteenPercent)
		button.tapPublisher.flatMap({
			Just(Tip.fifteenPercent)
		}).assign(to: \.value, on: tipSubject)
			.store(in: &cancellables)
		return button
	}()
	
	private lazy var twentyPercentTipButton: UIButton = {
		let button = buildTipButton(tip: .twentyPercent)
		button.tapPublisher.flatMap({
			Just(Tip.twentyPercent)
		}).assign(to: \.value, on: tipSubject)
			.store(in: &cancellables)
		return button
	}()
	
	private lazy var customTipButton: UIButton = {
		let button = UIButton()
		button.setTitle("Custom tip", for: .normal)
		button.titleLabel?.font = UIFont.avenirNextDemiBold(ofSize: 20)
		button.backgroundColor = .specialPrimaryColor
		button.tintColor = .white
		button.layer.cornerRadius = 8
		
		button.tapPublisher.sink { [weak self] _ in
			self?.handleCustomTipButton()
		}.store(in: &cancellables)
		return button
	}()
	
	private var buttonHorizontalStackView = UIStackView()
	private var buttonVerticalStackView = UIStackView()
	
	private let tipSubject: CurrentValueSubject<Tip, Never> = .init(.none)
	var valuePublisher: AnyPublisher<Tip, Never> {
		return tipSubject.eraseToAnyPublisher()
	}
	private var cancellables = Set<AnyCancellable>()
	
	
	init() {
		super.init(frame: .zero)
		
		setupViews()
		setConstraints()
		observe()
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
	
	private func handleCustomTipButton() {
		let alertController: UIAlertController = {
			let controller = UIAlertController(
				title: "Enter custom tip",
				message: nil,
				preferredStyle: .alert)
			controller.addTextField { textField in
				textField.placeholder = "Make it generous!"
				textField.keyboardType = .numberPad
				textField.autocorrectionType = .no
			}
			let cancelAction = UIAlertAction(
				title: "Cancel",
				style: .cancel)
			let okAction = UIAlertAction(
				title: "OK",
				style: .default) { [weak self] _ in
					guard let text = controller.textFields?.first?.text,
						  let value = Int(text) else { return }
					self?.tipSubject.send(.custom(value: value))
				}
			[okAction, cancelAction].forEach(controller.addAction(_:))
			return controller
		}()
		parentViewController?.present(alertController, animated: true)
	}
	
	private func resetTipButtons() {
		[tenPercentTipButton,
		fifteenPercentTipButton,
		twentyPercentTipButton,
		 customTipButton].forEach {
			$0.backgroundColor = .specialPrimaryColor
		}
		
		let text = NSMutableAttributedString(
			string: "Custom tip",
			attributes: [.font: UIFont.avenirNextBold(ofSize: 20) ?? .systemFont(ofSize: 20)])
		customTipButton.setAttributedTitle(text, for: .normal)
	}
	
	private func observe() {
		tipSubject.sink { [unowned self] tip in
			resetTipButtons()
			switch tip {
			case .none:
				break
			case .tenPercent:
				tenPercentTipButton.backgroundColor = .specialSecondaryColor
			case .fifteenPercent:
				fifteenPercentTipButton.backgroundColor = .specialSecondaryColor
			case .twentyPercent:
				twentyPercentTipButton.backgroundColor = .specialSecondaryColor
			case .custom(let value):
				customTipButton.backgroundColor = .specialSecondaryColor
				let text = NSMutableAttributedString(
					string: "$ \(value)",
					attributes: [
						.font: UIFont.avenirNextBold(ofSize: 20) ?? .systemFont(ofSize: 20)])
				text.addAttributes([
					.font: UIFont.avenirNextBold(ofSize: 14) ?? .systemFont(ofSize: 14)
				], range: NSMakeRange(0, 1))
				customTipButton.setAttributedTitle(text, for: .normal)
			}
		}.store(in: &cancellables)
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
