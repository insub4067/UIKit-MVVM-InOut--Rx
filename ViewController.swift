//
//  ViewController.swift
//  UIKit-Test
//
//  Created by 김인섭 on 2023/08/04.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ViewController: UIViewController {
    
    let viewModel: ViewModelable
    var disposeBag = DisposeBag()
    
    lazy var countButton: UIButton = {
        let button = UIButton()
        button.setTitle("\(viewModel.count)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    init(viewModel: ViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        bind()
    }
    
    func setLayout() {
        
        view.backgroundColor = .white
        view.addSubview(countButton)
        
        countButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func bind() {
        
        countButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.didTapButton()
        }
        .disposed(by: disposeBag)
        
        viewModel.count.asDriver(onErrorJustReturn: 0)
            .drive(onNext: { [weak self] value in
                self?.countButton.setTitle("\(value)", for: .normal)
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController {
    
    static func build() -> ViewController {
        let model = ViewModel()
        let controller = ViewController(viewModel: model)
        return controller
    }
}
