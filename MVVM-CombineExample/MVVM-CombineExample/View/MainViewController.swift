import UIKit
import SnapKit
import Combine

final class MainViewController: UIViewController {
	private let logoView = LogoView()
	private let resultView = ResultView()
	private let billInputView = BillInputView()
	private let tipInputView = TipInputView()
	private let splitInputView = SplitInputView()
	
	private var mainStackView = UIStackView()
	
	private let viewModel = CalculatoViewModel()
	private var cancellables = Set<AnyCancellable>()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setConstraints()
		
		bind()
	}
	
	private func setupViews() {
		view.backgroundColor = .specialBackgroundColor
		
		mainStackView = UIStackView(
			arrangedSubviews: [logoView, resultView, billInputView, tipInputView, splitInputView, UIView()],
			axis: .vertical,
			spacing: 36)
		
		view.addView(mainStackView)
	}
	
	private func bind() {
		
		let input = CalculatoViewModel.Input(
			billPublisher: billInputView.valuePublisher,
			tipPublisher: tipInputView.valuePublisher,
			splitPublisher: splitInputView.valuePublisher)
		
		let output = viewModel.transform(input: input)
		
		output.updateViewPublisher.sink { result in
			print(result)
		}.store(in: &cancellables)
	}
}

extension MainViewController {
	private func setConstraints() {
		
		mainStackView.snp.makeConstraints { make in
			make.leading.equalTo(view.snp.leadingMargin).offset(16)
			make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
			make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
			make.top.equalTo(view.snp.topMargin).offset(16)
		}
		
		logoView.snp.makeConstraints { make in
			make.height.equalTo(48)
		}
		
		resultView.snp.makeConstraints { make in
			make.height.equalTo(224)
		}
		
		billInputView.snp.makeConstraints { make in
			make.height.equalTo(56)
		}
		
		tipInputView.snp.makeConstraints { make in
			make.height.equalTo(56 + 56 + 16)
		}
		
		splitInputView.snp.makeConstraints { make in
			make.height.equalTo(56)
		}
	}
}
