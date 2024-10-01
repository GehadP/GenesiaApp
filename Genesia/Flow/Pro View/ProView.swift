//
//  ProView.swift
//  Genesia
//
//  Created by Gehad Gamal on 30/09/2024.
//

import SwiftUI

struct ProView: View {
    
    @Binding var path: NavigationPath
    // Access the dismiss action from the environment
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm:LandingFlowViewModel
    var body: some View {
        
        ZStack {
            // Background image with blur effect
            Image(vm.userChoices.selectedAvatar  ?? "") // Replace with your actual image name
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    Rectangle()
                        .fill(Color.black.opacity(0.4))
                        .blur(radius: 30)
                )
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.black.opacity(1)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        // Dismiss the current screen and navigate to another view
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            path.append("RelationshipSettingView")
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button("Restore") {
                        // Restore action
                    }
                    .foregroundColor(.white)
                }
                .padding()
                
                Spacer()
                
                Text("Genesia AI")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                
                Text("PRO")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 25) {
                    FeatureRow(icon: "infinity", text: "Unlimited Messages")
                    FeatureRow(icon: "lock.open", text: "Unlock Chat Photos")
                    FeatureRow(icon: "heart", text: "Romantic Partner")
                    FeatureRow(icon: "brain", text: "Personalized AI")
                }
                .padding()
                .background(Color.clear)
                .cornerRadius(15)
                
                VStack(spacing: 10) {
                    SubscriptionOptionButton(
                        period: "week",
                        price: "149.99",
                        currency: "EGP",
                        savePercentage: nil,
                        topText: "3 days FREE TRIAL, Auto Renewal"
                    ).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.5), lineWidth:0.5)
                    )
                    
                    SubscriptionOptionButton(
                        period: "year",
                        price: "1199.99",
                        currency: "EGP",
                        savePercentage: "90%",
                        topText: "Auto Renewal"
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.5), lineWidth:0.5)
                    )
                }
                .padding()
                
                Button(action: {
                    // Start plan action
                }) {
                    Text("Start Plan")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(32)
                }
                .padding(.horizontal, 30)
                
                HStack {
                    Button("Privacy") {
                        // Privacy action
                    }
                    Spacer()
                    Button("Terms") {
                        // Terms action
                    }
                }
                .foregroundColor(.gray)
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                // CustomBackButton() (optional custom back button)
            }
        }
    }
}

// Define the view that will be pushed
struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            Text(text)
                .foregroundColor(.white)
        }
    }
}

struct SubscriptionOptionButton: View {
    let period: String
    let price: String
    let currency: String
    let savePercentage: String?
    let topText:String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(topText)")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                
                Text("\(currency)\(price)/\(period), cancel anytime")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            if let save = savePercentage {
                Text("Save \(save)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color(white: 0.2))
        .cornerRadius(15)
    }
}

struct ProView_Previews: PreviewProvider {
    static var previews: some View {
        ProView(path: .constant(NavigationPath()))
    }
}
