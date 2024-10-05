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
    @State private var alertMessage = ""
    @State private var showAlert = false

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
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Login Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func handleLogin() {
        // Validate email and password before attempting login
        if userLogin.isValidEmail() && userLogin.isPasswordValid() {
            Auth.auth().signIn(withEmail: userLogin.email, password: userLogin.password) { authResult, error in
                if let error = error {
                    alertMessage = "Login error: \(error.localizedDescription)"
                    showAlert = true
                } else {
                    alertMessage = "Login successful!"
                    showAlert = true
                    // Navigate to the home page or handle successful login
                }
            }
        } else {
            alertMessage = "Invalid email or password"
            showAlert = true
        }
    }
}
#Preview {
    LoginView()
}
