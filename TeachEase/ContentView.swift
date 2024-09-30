//
//  ContentView.swift
//  TeachEase
//
//  Created by Kanchan Kaur on 2024-09-06.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State var isLoggedIn = Auth.auth().currentUser != nil

    var body: some View {
            NavigationView {
                RegisterView()  
                    .navigationBarHidden(true)
            }
        }
    
   }

#Preview {
    ContentView()
}
