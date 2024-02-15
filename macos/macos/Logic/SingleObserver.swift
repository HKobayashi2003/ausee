//
//  SingleObserver.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/16.
//

import Foundation

class SingleObserver<T> : ObservableObject {
    @Published var value: T
    init(value: T) {
        self.value = value
    }
}
