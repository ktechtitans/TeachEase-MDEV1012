//
//  LoginView.swift
//  TeachEase
//
//  Created by Kanchan Kaur on 2024-09-06.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State private var userLogin = UserLogin(email: "", password: "")
    
    var body: some View {
        VStack(spacing: 20) {
            Text("TeachEase")
                .font(.largeTitle)
                .bold()
                .padding(.top, 50)
                .padding(.bottom, 130)
            
            TextField("Enter your email", text: $userLogin.email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            SecureField("Enter your password", text: $userLogin.password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            Button(action: {
                handleLogin()
            }) {
                Text("Log in")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
    }
    
    func handleLogin() {
        // Validate email and password before attempting login
        if userLogin.isValidEmail() && userLogin.isPasswordValid() {
            Auth.auth().signIn(withEmail: userLogin.email, password: userLogin.password) { authResult, error in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                } else {
                    print("Login successful!")
                    // Navigate to the home page or handle successful login
                }
            }
        } else {
            print("Invalid email or password")
        }
    }
}
#Preview {
    LoginView()
}
