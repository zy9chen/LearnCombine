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
    @Published var users = [User]()
    private var cancellables = Set<AnyCancellable>()
    
    let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    init() {
        setupPublishers()
    }
    
    private func setupPublishers() {
        setupTimerPublisher()
        setupDataTaskPublisher()
    }
    
    private func setupDataTaskPublisher() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let httpReponse = response as? HTTPURLResponse,
                      httpReponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { users in
                self.users = users
            }
            .store(in: &cancellables)
    }
    
    private func setupTimerPublisher() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { value in
                self.time = self.formatter.string(from: value)
            }
            .store(in: &cancellables)
    }
    
}
