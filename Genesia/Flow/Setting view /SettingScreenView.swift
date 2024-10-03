//
//  SettingScreenView.swift
//  Genesia
//
//  Created by Gehad Gamal on 01/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var isBackgroundVideoOn = true
    @Environment(\.presentationMode) var presentationMode
    @Binding var path:NavigationPath
    var body: some View {
        ZStack {
            Color(Color.darkBlue)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    Spacer()
                    Text("Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Color.clear.frame(width: 40, height: 40)
                }
                .padding(.horizontal)
                
                VStack(spacing: 15) {
                    ToggleRow(title: "Background Video On", isOn: $isBackgroundVideoOn)
                    ButtonRow(title: "Share Genesia", icon: "square.and.arrow.up")
                    VStack(spacing: 20) {
                        ButtonRow(title: "About Codeway", icon: "book")
                        Divider().background(Color.white.opacity(0.2))
                        TextRow(title: "    Like us, Rate us ♡")
                        Divider().background(Color.white.opacity(0.2))
                        ButtonRow(title: "FAQ & Support", icon: "chevron.right")
                        Divider().background(Color.white.opacity(0.2))
                        TextRow(title: "     Email Support")
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    
                    VStack(spacing: 15) {
                        TextRow(title: "     Restore Purchase")
                        Divider().background(Color.white.opacity(0.2))
                        TextRow(title: "     Privacy Policy")
                        Divider().background(Color.white.opacity(0.2))
                        TextRow(title: "     Terms of Service")
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    
                    Button(action: {
                        print("Reset Data tapped")
                    }) {
                        Text("Reset Data")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(15)
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct ToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: Color.blue))
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}

struct ButtonRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {
            print("\(title) tapped")
        }) {
            HStack {
                Text(title)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: icon)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .cornerRadius(15)
    }
}

struct TextRow: View {
    let title: String
    
    var body: some View {
        Button(action: {
            print("\(title) tapped")
        }) {
            HStack {
                Text(title)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(path: .constant(NavigationPath()))
    }
}
