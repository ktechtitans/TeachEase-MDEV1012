//
//  RegisterView.swift
//  TeachEase
//
//  Created by Kanchan Kaur on 2024-09-06.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RegisterView: View {
    @State private var userRegistration = UserRegistration(email: "", password: "", confirmPassword: "")
    @State private var isSignedUp: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("TeachEase")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .bold()
                    .padding(.top, 50)
                    .padding(.bottom, 60)
                
                Text("Create new account")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(.bottom, 30)
                
                TextField("Enter your email", text: $userRegistration.email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                
                SecureField("Enter your password", text: $userRegistration.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                
                SecureField("Confirm password", text: $userRegistration.confirmPassword)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                
                Button(action: {
                    handleSignUp()
                }) {
                    Text("Sign up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top)
                
                Spacer()
                
                HStack {
                    Text("Have an account?")
                    NavigationLink(destination: LoginView()) {
                        Text("Log in")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                NavigationLink(destination: HomePageView(), isActive: $isSignedUp) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
    
    func handleSignUp() {
        if userRegistration.isPasswordValid() {
            Auth.auth().createUser(withEmail: userRegistration.email, password: userRegistration.password) { authResult, error in
                if let error = error {
                    print("Error during signup: \(error.localizedDescription)")
                } else {
                    isSignedUp = true
                }
            }
        } else {
            print("Passwords do not match")
        }
    }
}
#Preview {
    RegisterView()
}
