//
//  PreviewData.swift
//  expense_tracker
//
//  Created by Michael on 3/23/24.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date:"01/24/2022", institution: "Desjardins", account: "Visa", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "software", isPending: false, IsTransfer: false, isExpense: true, isEdited: false)

var transactionistPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
