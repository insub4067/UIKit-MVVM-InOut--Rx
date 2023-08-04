//
//  ViewModel.swift
//  UIKit-Test
//
//  Created by 김인섭 on 2023/08/04.
//

import Foundation
import RxSwift

protocol ViewInput {
    func didTapButton()
}

protocol ViewOutput {
    var count: BehaviorSubject<Int> { get set }
}

protocol ViewModelable: ViewInput, ViewOutput { }


class ViewModel: ViewModelable {
    
    var count = BehaviorSubject(value: 0)
    
    func didTapButton() {
        let value = try? count.value()
        count.onNext((value ?? 0) + 1)
    }
}
