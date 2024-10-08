//
//  AIFriendSelectionView.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//

import SwiftUI

struct AIFriend: Identifiable,Equatable {
    let id = UUID()
    let image: String
    let backgroundImage: String
}
struct AIFriendSelectionView: View {
    @State private var selectedFriend: AIFriend
    @EnvironmentObject var vm:LandingFlowViewModel
    @Binding var path: NavigationPath
    let friends: [AIFriend] = [
        AIFriend(image: "person1", backgroundImage: "person1"),
        AIFriend(image: "person2", backgroundImage: "person2"),
        AIFriend(image: "person3", backgroundImage: "person3"),
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
                        // Handle back action
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
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
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
                    .padding(.horizontal, 20)
                    .padding(.leading, UIScreen.main.bounds.width / 2 - 50) // Add extra padding at the start
                }
                .content.offset(x: -20)
                Button(action: {
                    
                    path.append("CharacterCreationView")
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.darkBlue)
                        .frame(width: 300) // Fixed width
                        .padding()
                        .background(Color.white)
                        .cornerRadius(32)
                }
                .padding(.bottom, 30)
            }
        }.onChange(of: selectedFriend) { oldValue, newValue in
            vm.userChoices.selectedAvatar = newValue.image
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
