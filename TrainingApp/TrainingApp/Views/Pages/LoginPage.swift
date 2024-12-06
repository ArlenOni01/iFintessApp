//
//  LoginPage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/15/23.
//

import SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.3)
                    .foregroundColor(.white)
                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "password",
                              isSecureField: true)
                    
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Forgot Password?")
                            .padding()
                    })
                    
                    //sign in button
                    
                    Button(action: {
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    },
                           label: {
                        HStack{
                            Text("SIGN IN")
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)

                    })
                    .background(Color.blue)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(7)
                    
                    NavigationLink{
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 3){
                            Text("Don't have an account?")
                            Text("Sign up!")
                                .fontWeight(.bold)
                            
                        }
                        .font(.system(size: 14))
                    }   
                }
            }
        }
    }
}
extension LoginPage: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginPage()
}
