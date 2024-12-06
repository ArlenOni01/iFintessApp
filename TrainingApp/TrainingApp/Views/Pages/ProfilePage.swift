//
//  ProfilePage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/2/23.
//

import SwiftUI

struct ProfilePage: View {
    let profiles = profileList
    
    @EnvironmentObject var viewModel : AuthViewModel
        
    @State private var birthdate = Date()
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        //Text(user.initials)
                        Text(User.MOCK_USER.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width:72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack (alignment: .leading, spacing: 4){
                            //Text(user.fullname)
                            Text(User.MOCK_USER.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            //Text(user.email)
                            Text(User.MOCK_USER.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                }

                Section("Personal") {
                    SettingsRowView(imageName: "person.crop.circle", title: "Weight", tintColor: Color(.blue))
                    SettingsRowView(imageName: "person.crop.circle", title: "Height", tintColor: Color(.blue))
                    DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
                }
                
                Section("General") {
                    SettingsRowView(imageName: "scalemass.fill", title: "BMI Calculator", tintColor: Color(.blue))
                    SettingsRowView(imageName: "star.fill", title: "Favorites", tintColor: Color(.blue))
                }
                
                Section("Account") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                    }
                    
                    Button {
                        print("Delete Account..")
                    } label: {
                        SettingsRowView(imageName: "x.circle.fill", title: "Delete Account", tintColor: .red)
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfilePage()
}
