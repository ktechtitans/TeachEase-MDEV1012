//
//  UserLogin.swift
//  TeachEase
//
//  Created by Kanchan Kaur on 2024-09-30.
//

import Foundation

struct UserLogin {
    var email: String
    var password: String

    func isValidEmail() -> Bool {
        // Basic email validation logic (you can add more robust validation)
        return email.contains("@") && email.contains(".")
    }

    func isPasswordValid() -> Bool {
        // Ensure password is at least 6 characters long
        return password.count >= 6
    }
}
