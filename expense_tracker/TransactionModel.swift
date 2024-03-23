//
//  Transaction.swift
//  expense_tracker
//
//  Created by Michael on 3/23/24.
//

import Foundation

struct Transaction: Identifiable, Decodable {
    let id: Int
    let date:String
    let institution: String
    let account: String
    var merchant: String // Var can be changed
    let amount: Double
    let type: TransactionType.RawValue  //MARK String version
    var categoryId: Int
    var category: String
    let isPending: Bool
    var IsTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount:Double{
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
}

enum TransactionType:String {
    case debit = "debit"
    case credit = "credit"
}
