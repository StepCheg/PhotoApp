//
//  TextFieldFormatter.swift
//  ImageApp
//
//  Created by Stepan Chegrenev on 24.11.2019.
//  Copyright © 2019 Stepan Chegrenev. All rights reserved.
//

import Foundation

class TextFieldFormatter {
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+X (XXX) XXX XX-XX"

        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
