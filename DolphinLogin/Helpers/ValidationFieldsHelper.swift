//
//  ValidationFieldsHelper.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 18.11.2023.
//

import Foundation

struct ValidationFieldsHelper {
    
    static func isValidName(_ name: String) -> Bool {
        let namePredicate = NSPredicate(format:"SELF MATCHES %@", "^[a-zA-Zа-яА-Я ]+$")
        return namePredicate.evaluate(with: name)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    static func isValidAge(_ age: String) -> Bool {
        let ageRegex = "^[0-9]{1,2}$"
        let agePredicate = NSPredicate(format:"SELF MATCHES %@", ageRegex)
        return agePredicate.evaluate(with: age)
    }
}
