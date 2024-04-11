//
//  TransactionListvireModel.swift
//  expense_tracker
//
//  Created by Michael on 3/23/24.
//

import Foundation
import Combine
import Collections

//OrderedDictionary is from collection
typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    // Set up parameters with combine
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    } //Call getTransactions when class form instance.
    
    func getTransactions()  {
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
                    print("Error Fetching transaction", error)
                case .finished:
                    print("Finished fecthing transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellables)
            }
    
    func groupTransactionBymonth() -> TransactionGroup {
        guard !transactions.isEmpty else {return[:]}
        
        let groupedTransactions = TransactionGroup(grouping: transactions){ $0.month }
        
        return groupedTransactions
        
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        print("Accumulated")
        guard transactions.isEmpty else { return [] }
        
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print(dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60*60*24){
            let dailyExpense = transactions.filter {$0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpense.reduce(0) {$0 - $1.signedAmount}
            
            sum += dailyTotal
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "DailyTotal:", dailyTotal, "sum:", sum)
        }
        return cumulativeSum
            
        }
    }
    
    
