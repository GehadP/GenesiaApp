//
//  ChatListScreen.swift
//  Genesia
//
//  Created by Gehad Gamal on 01/10/2024.
//

import SwiftUI


struct ChatListScreen: View {
    @EnvironmentObject var landingFlowVM: LandingFlowViewModel
    @StateObject var vm: ChatListViewModel
    @Binding var path: NavigationPath
    @State private var searchText = ""
    
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
                
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                if filteredAIModels().isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(filteredAIModels()) { preview in
                            ChatPreviewRow(item: preview)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
                
                Button(action: {
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
    
    private func filteredAIModels() -> [AIModel] {
        if searchText.isEmpty {
            return InMemoryPersistance.getAIModels()
        } else {
            return InMemoryPersistance.getAIModels().filter { $0.aiName.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $text)
                .foregroundColor(.white)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
    }
}

struct EmptyStateView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
            
            Text("No Results Found")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top)
            
            Text("Try adjusting your search or filters")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            isAnimating = true
        }
    }
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
        return ChatListScreen(vm: .init(), path: .constant(NavigationPath()))
            .environmentObject(LandingFlowViewModel())
    }
}
