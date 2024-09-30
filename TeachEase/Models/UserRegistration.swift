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
    
    func isPasswordValid() -> Bool {
        return password == confirmPassword
    }
}
