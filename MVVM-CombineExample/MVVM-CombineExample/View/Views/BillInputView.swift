import UIKit
import Combine
import CombineCocoa

final class BillInputView: UIView {
	
	private let headerView: HeaderView = {
		let view = HeaderView()
		view.configure(topText: "Enter", bottomText: "your bill")
		return view
	}()
	
	private let textFieldContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()
	
	private let currencyDenominationLabel: UILabel = {
		let label = UILabel(
			text: "$",
			font: UIFont.avenirNextBold(ofSize: 24) ?? .systemFont(ofSize: 24))
		label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		return label
	}()
	
	private lazy var textField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .none
		textField.font = UIFont.avenirNextDemiBold(ofSize: 28)
		textField.keyboardType = .decimalPad
		textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
		textField.tintColor = .specialTextColor
		textField.textColor = .specialTextColor
		// Add toolbar
		let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
		toolBar.barStyle = .default
		toolBar.sizeToFit()
		let doneButton = UIBarButtonItem(
			title: "Done",
			style: .plain,
			target: self,
			action: #selector(doneButtonPressed))
		toolBar.items = [
			UIBarButtonItem(
				barButtonSystemItem: .flexibleSpace,
				target: nil,
				action: nil),
			doneButton]
		toolBar.isUserInteractionEnabled = true
		textField.inputAccessoryView = toolBar
		return textField
	}()
	
	private let billSubject: PassthroughSubject<Double, Never> = .init()
	private var cancellables = Set<AnyCancellable>()
	
	var valuePublisher: AnyPublisher<Double,Never> {
		return billSubject.eraseToAnyPublisher()
	}
	
	init() {
		super.init(frame: .zero)
		setupViews()
		setConstraints()
		observe()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		textFieldContainerView.layer.cornerRadius = 8
	}
	
	private func setupViews() {
		[headerView, textFieldContainerView].forEach(addView(_:))
		textFieldContainerView.addView(currencyDenominationLabel)
		textFieldContainerView.addView(textField)
	}
	
	private func observe() {
		textField.textPublisher.sink {[unowned self] text in
			guard let text = text else { return }
			billSubject.send(text.doubleValue ?? 0)
		}.store(in: &cancellables)
	}
	
	@objc private func doneButtonPressed() {
		textField.resignFirstResponder()
	}
}

extension BillInputView {
	private func setConstraints() {
		headerView.snp.makeConstraints { make in
		  make.leading.equalToSuperview()
		  make.centerY.equalTo(textFieldContainerView.snp.centerY)
		  make.width.equalTo(68)
		  make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
		}
		
		textFieldContainerView.snp.makeConstraints { make in
		  make.top.trailing.bottom.equalToSuperview()
		}
		
		currencyDenominationLabel.snp.makeConstraints { make in
		  make.top.bottom.equalToSuperview()
		  make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
		}
		
		textField.snp.makeConstraints { make in
		  make.top.bottom.equalToSuperview()
		  make.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
		  make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
		}
	}
}
