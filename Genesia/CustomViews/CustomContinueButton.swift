//
//  CustomContinueButton.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//

import SwiftUI


struct CustomContinueButton: View {
  let title:String
  let titleColor:Color
  @Binding var isDisabled:Bool
  
    var body: some View {
      Text(title)
        .font(.headline)
        .foregroundColor(titleColor)
        .padding()
        .frame(width: 300, height: 50, alignment: .center)
        .background(isDisabled ? .gray.opacity(0.5) : .white)
        .cornerRadius(20)
        .shadow(color: isDisabled ? .clear :  Color.white.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    CustomContinueButton(title: "Continue", titleColor: .darkBlue,isDisabled: .constant(false))
}
