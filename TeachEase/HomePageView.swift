//
//  HomePageView.swift
//  TeachEase
//
//  Created by Kanchan Kaur on 2024-09-06.
//

import SwiftUI


struct HomePageView: View {
    var body: some View {
        TabView {
            // Home Tab
            Text("Welcome to the Home Page!")
                .font(.largeTitle)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            // Search Tab
            Text("Search Page")
                .font(.largeTitle)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            // Profile Tab
            Text("Profile Page")
                .font(.largeTitle)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    HomePageView()
}
