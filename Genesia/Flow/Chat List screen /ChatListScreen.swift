//
//  ChatListScreen.swift
//  Genesia
//
//  Created by Gehad Gamal on 01/10/2024.
//

import SwiftUI

struct ChatListScreen: View {

    @EnvironmentObject var landingFlowVM:LandingFlowViewModel
    @StateObject var vm:ChatListViewModel
    @Binding var path:NavigationPath
    var body: some View {
        ZStack {
            Color(Color.darkBlue)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack {
                    Text("Genesia AI")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                        Text("PRO")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(15)
                    Button(action: {
                        path.append("SettingsView")
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                List {
                    ForEach(InMemoryPersistance.getAIModels()) { preview in
                        ChatPreviewRow(item: preview)
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                
                Button(action: {
                    // Action for starting new chat
                    
                    path.append(UserNamePushedFrom.startNewChat)
                }) {
                    Text("Start New Chat")
                        .font(.headline)
                        .foregroundColor(.darkBlue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(32)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
          }
        }
    }
}

struct ChatPreviewItem: Identifiable {
    let id = UUID()
    let name: String
    let message: String
    let time: String
    let image: String
}

struct ChatPreviewRow: View {
    let item: AIModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(item.selectedAvatar ?? "")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.aiName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Hey there! It is Hdhh. 🌸 I'm s...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Text("Now")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct ChatListScreen_Previews: PreviewProvider {
    static var previews: some View {
       
        return ChatListScreen(vm: .init(),path: .constant(NavigationPath()))
          .environmentObject(LandingFlowViewModel())
    }
}
final class ChatListViewModel:ObservableObject {
  @Published var aiModels:[AIModel] = []
  
  init() {
    aiModels = InMemoryPersistance.getAIModels()
  }
  
  func deleteAIModel(modelID:UUID) {
    InMemoryPersistance.deleteAIModel(modelID: modelID)
    aiModels = InMemoryPersistance.getAIModels()
  }
  
  func pinModel(modelID:UUID,pinned:Bool) {
    InMemoryPersistance.pinModel(modelID: modelID, pinned: pinned)
    aiModels = InMemoryPersistance.getAIModels()
  }
}
