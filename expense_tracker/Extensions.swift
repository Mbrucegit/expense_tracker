//
//  Extensions.swift
//  expense_tracker
//
//  Created by Michael on 3/22/24.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter{
    static let allNumbericUSA: DateFormatter = {
        print("'Iniitial DateFromatter'")
        let formatter = DateFormatter()
        formatter.dateFormat="MM/dd/yyyy"
        return formatter
    }()    //call hte formate methods
}

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumbericUSA.date(from: self) else{ return Date() }
        return parsedDate
    }
}
