//
//  ChatScrenView.swift
//  Genesia
//
//  Created by Gehad Gamal on 30/09/2024.
//

import SwiftUI

enum ChatScreenViewPushedFrom:Hashable {
    case chatList
    case personalitySelection
}
struct ChatScreenView: View {
    @EnvironmentObject var vm:LandingFlowViewModel
    @Binding var path: NavigationPath
    @State var showSetRelationShipView:Bool
    @State var showProScreen:Bool = false
    
    var body: some View {
        ZStack{
            Color.darkBlue
            .ignoresSafeArea()
            VStack {
                
                headerView
                Spacer()
                HStack{
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
            }

                //.background(Color.darkBlue.ignoresSafeArea())
            if showSetRelationShipView {
                relationShipView
                    .transition(.move(edge: .bottom))
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
extension ChatScreenView {

    private var headerView:some View {
      HStack {
        CustomBackButton()
        Spacer()
          Image(vm.userChoices.selectedAvatar )
          .resizable()
          .frame(width: 50,height: 50)
          .clipShape(Circle())
        VStack(alignment:.leading) {
          HStack{
              Text(vm.userChoices.aiName)
            Text("·")
              .font(.system(size: 30))
              .bold()
              .foregroundStyle(.green)
          }
          Text("Tap for more info")
            .font(.footnote)
            .foregroundStyle(.gray)
        }.foregroundStyle(.white)
        Spacer()
        HStack {
          HStack {
            Text("PRO")
              .foregroundStyle(.white)
              .bold()
          }.shadow(color: .white, radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
            .frame(width: 50)
            .padding(10)
            .background(
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white)
            )
            .onTapGesture {
              showProScreen = true
            }
          Image(systemName: "video.fill")
            .foregroundStyle(.gray)
            .font(.system(size: 22))
            .padding(.leading,10)
        }
      }
      .padding()
    }

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
                            CustomXButton()
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
                                
                                Image(vm.userChoices.selectedAvatar )
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
        ChatScreenView(path: .constant(NavigationPath()), showSetRelationShipView: false)
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
