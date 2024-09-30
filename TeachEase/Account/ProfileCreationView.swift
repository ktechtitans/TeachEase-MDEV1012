//
//  ProfileCreationView.swift
//  TeachEase
//
//  Created by Kanchan Kaur on 2024-09-06.
//

import SwiftUI
import FirebaseAuth
import PhotosUI

struct ProfileCreationView: View {
    @State var profileImage: Image? = nil
    @State var username: String = ""
    @State var nickname: String = ""
    @State var dateOfBirth = Date()
    @State var bio: String = ""
    @State var showPhotoActionSheet = false
    @State var showPhotoLibrary = false
    @State var selectedPhoto: PhotosPickerItem?
    @State private var isSaving = false
    @State private var saveError: Error?
    @State private var profileId: String = ""
    
    @State private var shouldNavigateToProfile = false
    @State private var savedProfile: Profile?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Create Your Profile")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading) {
                        Button(action: {
                            showPhotoActionSheet.toggle()
                        }) {
                            ZStack {
                                if let image = profileImage {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                                        )
                                        .shadow(radius: 10)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                                        )
                                        .shadow(radius: 10)
                                }
                            }
                            .frame(width: 120, height: 120)
                            .padding()
                        }
                        .confirmationDialog("Select Photo", isPresented: $showPhotoActionSheet) {
                            Button("Photo Library") {
                                showPhotoLibrary.toggle()
                            }
                        }
                        .photosPicker(isPresented: $showPhotoLibrary, selection: $selectedPhoto, photoLibrary: .shared())
                        .onChange(of: selectedPhoto) { newValue in
                            Task {
                                if let photoItem = newValue,
                                   let photoData = try? await photoItem.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: photoData) {
                                    profileImage = Image(uiImage: uiImage)
                                }
                            }
                        }
                    }
                
                    VStack(alignment: .leading) {
                        Text("Username")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        TextField("Enter your username", text: $username)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Nickname")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        TextField("Enter your nickname", text: $nickname)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Date of Birth")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        DatePicker("", selection: $dateOfBirth, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        TextEditor(text: $bio)
                            .frame(minHeight: 100)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            }
                    }
                    
                    Button(action: saveProfile) {
                        Text("Save Profile")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    .disabled(isSaving)
                    
                    if let error = saveError {
                        Text("Error saving profile: \(error.localizedDescription)")
                            .foregroundColor(.red)
                    }
                    
                    NavigationLink(
                        destination: UserProfileView(profile: savedProfile ?? Profile(id: "", username: "", nickname: "", dateOfBirth: Date(), bio: "", profileImageUrl: "")),
                        isActive: $shouldNavigateToProfile
                    ) {
                        EmptyView()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)
            }
            .navigationBarTitle("Profile Page", displayMode: .inline)
        }
    }
    
    private func saveProfile() {
        isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSaving = false
            shouldNavigateToProfile = true
            savedProfile = Profile(id: "123", username: username, nickname: nickname, dateOfBirth: dateOfBirth, bio: bio, profileImageUrl: "image-url")
        }
    }
}

struct Profile {
    let id: String
    let username: String
    let nickname: String
    let dateOfBirth: Date
    let bio: String
    let profileImageUrl: String
}

struct UserProfileView: View {
    let profile: Profile
    
    var body: some View {
        Text("Welcome, \(profile.username)!")
            .font(.largeTitle)
    }
}

#Preview {
    ProfileCreationView()
}
