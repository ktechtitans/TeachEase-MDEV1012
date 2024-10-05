//
//  UserRegistration.swift
//  TeachEase
//
//  Created by Kanchan Kaur on 2024-09-30.
//

import Foundation

struct UserRegistration {
    var email: String
    var password: String
    var confirmPassword: String
    
    // Basic email validation
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // Password validation (min 6 characters)
    func isPasswordValid() -> Bool {
        return password.count >= 6
    }
}

