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
    var body: some View {
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
    }
}

struct ChatScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreenView(path: .constant(NavigationPath()))
            .environmentObject(LandingFlowViewModel())
    }
}
