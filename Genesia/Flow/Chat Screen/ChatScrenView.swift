//
//  ChatScrenView.swift
//  Genesia
//
//  Created by Gehad Gamal on 30/09/2024.
//

import SwiftUI

struct ChatScreenView: View {
    @EnvironmentObject var vm:LandingFlowViewModel
    @Binding var path: NavigationPath
    @State var showSetRelationShipView:Bool = true
    @State var showProScreen:Bool = false
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                // Message input area
                HStack {
                    TextField("Type your message...", text: .constant(""))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        // Add send message action
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.darkBlue)
            }.navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        CustomBackButton()
                    }
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(vm.userChoices.selectedAvatar ?? "person1")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(vm.userChoices.aiName)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                HStack {
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 8, height: 8)
                                    
                                    Text("Tap for more info")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack{
                            Button(action: {
                                
                            }) {
                                Text("PRO")
                                    .font(.headline)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.gray.opacity(0.3))
                                    )
                                    .foregroundColor(.white)
                            }
                            Button(action: {
                            }) {
                                Image(systemName: "video.fill")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.clear)
                                    )
                            }
                            
                        }
                        
                    }
                    
                }
            
                .background(Color.darkBlue.ignoresSafeArea())
            if showSetRelationShipView {
                relationShipView
            }
        
        }
    }
}
extension ChatScreenView {
    private var relationShipView: some View {
      ZStack {
        BlurBackground(style: .dark)
          .ignoresSafeArea()
          .onTapGesture {
            withAnimation {
              showSetRelationShipView = false
            }
          }
        VStack {
          Spacer()
          RoundedTopCorners(radius: 30)
            .fill(Color.darkBlue)
            .frame(height:450)
            .overlay {
              VStack {
                  CustomBackButton()
                  .offset(x:-150)
                  .onTapGesture {
                    withAnimation {
                      showSetRelationShipView = false
                    }
                  }
                ZStack {
                  Circle()
                    .fill(Color.white)
                    .frame(width: 105, height: 105) // Adjust the size to create the desired border thickness
                  
                    Image(vm.userChoices.selectedAvatar ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                }
                Text("Set Your Relatioship with\n \(vm.userChoices.aiName)")
                  .font(.system(size: 25))
                  .fontWeight(.semibold)
                  .foregroundStyle(.white)
                  .multilineTextAlignment(.center)
                  .padding()
                Text("Friends")
                  .foregroundStyle(.white)
                  .font(.system(size: 20))
                  .fontWeight(.semibold)
                  .frame(width: 300, height: 60, alignment: .center)
                  .background(RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white))
                  .overlay {
                    RoundedRectangle(cornerRadius: 30)
                      .fill(Color.white.opacity(0.4))
                  }
                  .onTapGesture {
                    withAnimation {
                      showSetRelationShipView = false
                    }
                  }
                RoundedRectangle(cornerRadius: 30)
                  .frame(width:300,height:60)
                  .foregroundStyle(.white.opacity(0.1))
                  .padding(5)
                  .overlay{
                    HStack {
                      Image(systemName: "lock.fill")
                      Text("Romantic Partners")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    }.foregroundStyle(.white)
                  }
                  .onTapGesture {
                    showProScreen = true
                  }
              }
            }
        }.ignoresSafeArea()
      }
    }

}
struct ChatScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreenView(path: .constant(NavigationPath()))
            .environmentObject(LandingFlowViewModel())
    }
}



struct RoundedTopCorners: Shape {
  var radius: CGFloat = .infinity
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
    path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                radius: radius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false)
    path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
    path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                radius: radius,
                startAngle: .degrees(270),
                endAngle: .degrees(0),
                clockwise: false)
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    return path
  }
}
