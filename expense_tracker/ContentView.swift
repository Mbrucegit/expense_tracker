//
//  ContentView.swift
//  expense_tracker
//
//  Created by Michael on 3/22/24.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
//    var demoData: [Double] = [2,4,3,6,8,2,4,3,6,100]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing:24){
                    //MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    let data = transactionListVM.accumulateTransactions()
                    let totalExpenses = data.last?.1 ?? 0
                    LineChartView(data: totalExpenses, title:"Title")
                        .frame(width: 220, height: 220)
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
//        transactionListVM.transactions = transactionistPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group{
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
