//
//  AIFriendSelectionView.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//

import SwiftUI

struct AIFriend: Identifiable {
    let id = UUID()
    let image: String
    let backgroundImage: String
}

struct AIFriendSelectionView: View {
    @State private var selectedFriend: AIFriend
    @Binding var path:NavigationPath
    let friends: [AIFriend] = [
        AIFriend(image: "onboading1", backgroundImage: "onboading1"),
        AIFriend(image: "onboading2", backgroundImage: "onboading2"),
        AIFriend(image: "onboading3", backgroundImage: "onboading3"),
        AIFriend(image: "onboading1", backgroundImage: "onboading1")
    ]
    
    init(path: Binding<NavigationPath>) {
        _selectedFriend = State(initialValue: friends[0])
        _path = path
    }
    var body: some View {
        ZStack {
            // Background Image
            Image(selectedFriend.backgroundImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                }
                
                Text("Choose your AI Friend")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                Spacer()
            
                HStack(spacing: 20) {
                    ForEach(friends) { friend in
                        Button(action: {
                            selectedFriend = friend
                        }) {
                            Image(friend.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: selectedFriend.id == friend.id ? 3 : 0)
                                )
                        }
                    }
                }
                .padding(.bottom, 20)
                
                // Continue Button
                Button(action: {
                    // Handle continue action
                    path.append("CharacterCreationView")
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.darkBlue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(32)
                        .padding(.horizontal, 40)
                        .background(Color.white)
                       
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            CustomBackButton()
          }
        }
    }
}

struct AIFriendSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AIFriendSelectionView(path: .constant(NavigationPath()))
    }
}
