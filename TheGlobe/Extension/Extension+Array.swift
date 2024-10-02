//
//  Extension.swift
//  TheGlobe
//
//  Created by Daljeet Singh on 01/10/24.
//

import Foundation

extension Array where Element == String {
    func joined(separator: String, and lastSeparator: String) -> String {
        guard count > 1 else { return self.first ?? "" }
        guard let lastElement = self.last else { return "" }
        return dropLast().joined(separator: separator) + lastSeparator + lastElement
    }
}
