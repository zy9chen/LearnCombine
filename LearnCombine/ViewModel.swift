//
//  ViewModel.swift
//  LearnCombine
//
//  Created by Zhaoyang Chen on 2020-11-25.
//

import SwiftUI
import Combine

final class ViewModel: ObservableObject {
    @Published var time = ""
    private var anyCancellable: AnyCancellable?
    
    let formatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    init() {
        setupPublishers()
    }
    
    private func setupPublishers() {
        anyCancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { value in
                self.time = self.formatter.string(from: value)
            }
    }
}
