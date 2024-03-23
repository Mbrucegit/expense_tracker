//
//  TransactionListvireModel.swift
//  expense_tracker
//
//  Created by Michael on 3/23/24.
//

import Foundation
import Combine

final class TransactionListViewModel: ObservableObject{
    @Published var transactions: [Transaction] = []
    
    private var cancellables=Set<AnyCancellable>()
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error Fetching transaction", error.localizedDescription)
                case .finished:
                    print("Finished fecthing transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellables)
                
            }
    }
    
