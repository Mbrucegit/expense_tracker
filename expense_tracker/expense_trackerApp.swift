//
//  expense_trackerApp.swift
//  expense_tracker
//
//  Created by Michael on 3/22/24.
//

import SwiftUI

@main
struct expense_trackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM )
        }
    }
}
