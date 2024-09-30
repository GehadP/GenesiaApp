//
//  OnboardingScreen.swift
//  Genesia
//
//  Created by Gehad Gamal on 28/09/2024.
//

import SwiftUI

struct OnboardingScreen: View {
    let imageNames = ["onboading1",
                      "onboading2",
                      "onboading3"
    ]
    
    @State private var currentIndex = 0
    var body: some View {
        ZStack{
            Color.darkBlue
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Genesia AI")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Text("The AI friend who is always there for you")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                Spacer()
                
                
                Button(action: {
                    // Add action for button tap
                }) {
                    Text("Let's Start")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(32)
                        .padding(.horizontal, 40)
                }
                Text("By signing up, you agree to our")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.6))
                    .multilineTextAlignment(.center)
                VStack(spacing:0) {
                    Text("By signing up, you agree to our")
                        .foregroundStyle(.gray)
                        .font(.caption2)
                        .frame(width: 200, alignment: .center)
                        .padding(.top)
                    HStack(spacing: 5) {
                        Button {
                            // showTermsOfService = true
                        } label: {
                            Text("Terms of Service")
                                .foregroundStyle(.gray)
                                .font(.caption)
                                .underline()
                        }
                        Text("and")
                            .foregroundStyle(.gray)
                            .font(.caption)
                        
                        Button {
                            // showPrivacyPolicy = true
                        } label: {
                            Text("Privacy Policy")
                                .foregroundStyle(.gray)
                                .font(.caption)
                                .underline()
                        }
                    }
                    .padding(.bottom,30)
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden()
        .background {
            backgroundView
        }
    }
}

#Preview {
    OnboardingScreen()
}


extension OnboardingScreen {
    private var backgroundView: some View {
        ZStack(alignment:.center) {
            Image(imageNames[currentIndex])
                .resizable()
                .scaledToFill()
                .transition(.opacity)
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.darkBlue, .clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .ignoresSafeArea()
        }.ignoresSafeArea()
    }
}
