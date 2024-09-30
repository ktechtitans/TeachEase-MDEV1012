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
        return email.contains("@") && email.contains(".")
    }
    
    func isPasswordValid() -> Bool {
        return !password.isEmpty
    }
}
