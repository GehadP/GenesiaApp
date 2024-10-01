//
//  RelationshipSettingView.swift
//  Genesia
//
//  Created by Gehad Gamal on 30/09/2024.
//

import SwiftUI

struct RelationshipSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedRelationship: Relationship = .friends
    @Binding var path: NavigationPath
    @EnvironmentObject var vm:LandingFlowViewModel
    enum Relationship {
        case friends, romanticPartners
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer() 
                VStack(spacing: 20) {
                    
                    ZStack {
                        HStack {
                            Button(action: { dismiss() }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                                    .padding(10)
                                    .background(Color(UIColor.systemGray4))
                                    .clipShape(Circle())
                            }
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Image(vm.userChoices.selectedAvatar ?? "") // Replace with your actual image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }.padding(.top,20)
                    
                    Text("Set Your Relationship with\nGg")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    VStack(spacing: 10) {
                        Button(action: { selectedRelationship = .friends }) {
                            Text("Friends")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background( Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(32)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 32)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                        
                        Button(action: { /* Action for Romantic Partners */ }) {
                            HStack {
                                Image(systemName: "lock.fill")
                                Text("Romantic Partners")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(32)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .frame(height: geometry.size.height / 2 + 20)
                .background(.darkBlue)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
        .preferredColorScheme(.dark)
    }
}

// Extension to apply corner radius to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// Custom shape for rounded corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct RelationshipSettingView_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipSettingView(path: .constant(NavigationPath()))
    }
}
