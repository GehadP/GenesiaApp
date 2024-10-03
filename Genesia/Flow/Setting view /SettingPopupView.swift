//
//  SettingPopupView.swift
//  Genesia
//
//  Created by Gehad Gamal on 03/10/2024.
//
import SwiftUI


struct SettingPopupView<PrimaryButton: View, SecondaryButton: View>: View {
  let title:String
  let message:String
  let firstButton:PrimaryButton
  let secondButton:SecondaryButton
  
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        VStack(spacing: 30){
          VStack(spacing:15) {
            Text(title)
              .font(.system(size: 22))
              .fontWeight(.bold)
              .foregroundStyle(.white)
            Text(message)
              .multilineTextAlignment(.center)
              .font(.system(size: 16))
              .foregroundStyle(.white)
          }
          VStack(spacing:15) {
              firstButton
              secondButton
          }
        }.padding()
          .background(
            RoundedRectangle(cornerRadius: 32)
              .foregroundStyle(.darkBlue)
          )
      }.ignoresSafeArea()
        .frame(width: geometry.size.width, height: geometry.size.height)

    }
  }
}

#Preview {
    SettingPopupView(title: "Are you sure?", message: "All of your data and AI Characters will be erased permanantely", firstButton: Button("Reset Data"){
    
  }, secondButton: Button("Cancel"){} )
}
