//
//  SettingScreenView.swift
//  Genesia
//
//  Created by Gehad Gamal on 01/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var isBackgroundVideoOn = true
    @State var showCustomPopUp:Bool = false
    @EnvironmentObject var vm:LandingFlowViewModel
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
                        showCustomPopUp = true
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
            if showCustomPopUp {
              BlurBackground(style: .dark)
                .transition(.opacity)
                .zIndex(1)
                .onTapGesture {
                  withAnimation {
                    showCustomPopUp = false
                  }
                }
              popupView
                .transition(.opacity)
                .frame(width: 300, height: 400)
                .zIndex(2)
              
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
extension SettingsView {
    private var popupView:some View {
        SettingPopupView(title: "Are you sure?",
                      message: "All of your data and AI Characters will be erased permanently.",
                      firstButton:RoundedButton(title: "Reset Data", titleColor: .red, isDisabled: .constant(false)).onTapGesture {
       vm.clear()
        path.removeLast(path.count)
      }, secondButton:Button(action: {
        withAnimation {
          showCustomPopUp = false
        }
      }, label: {
        Text("Cancel")
          .foregroundStyle(.white)
      }).padding()
      ).transition(.opacity)
        .frame(width: 300, height: 400)
    }
}

struct RoundedButton: View {
  let title:String
  let titleColor:Color
  @Binding var isDisabled:Bool
  
    var body: some View {
      Text(title)
        .font(.headline)
        .foregroundColor(titleColor)
        .padding()
        .frame(width: 250, height: 45, alignment: .center)
        .background(isDisabled ? .gray.opacity(0.5) : .white)
        .cornerRadius(20)
    }
}

#Preview {
    RoundedButton(title: "Let's Start", titleColor: .darkBlue,isDisabled: .constant(false))
}


struct BlurBackground: UIViewRepresentable {
  let style: UIBlurEffect.Style
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
    return effectView
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    uiView.effect = UIBlurEffect(style: style)
  }
}
