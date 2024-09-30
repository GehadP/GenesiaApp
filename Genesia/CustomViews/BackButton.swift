//
//  BackButton.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//


import SwiftUI

struct CustomBackButton: View {
  @Environment(\.dismiss) var dismiss
  var body: some View {
    Button {
      dismiss.callAsFunction()
    } label: {
      ZStack {
        Circle()
          .fill(.gray.opacity(0.5))
          .frame(width: 35, height: 35)
        Image(systemName: "chevron.left")
          .foregroundStyle(.darkBlue)
          .font(.system(size: 15))
          .bold()
      }
    }
  }
}

#Preview {
  CustomBackButton()
}

