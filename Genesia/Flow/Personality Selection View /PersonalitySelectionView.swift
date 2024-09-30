//
//  PersonalitySelectionView.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//

import SwiftUI

struct PersonalityOption: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
}

struct PersonalitySelectionView: View {
    @State private var selectedPersonality: UUID?
    @Binding var path: NavigationPath
    
    let personalities: [PersonalityOption] = [
        PersonalityOption(emoji: "😉", title: "Flirty & Relaxed"),
        PersonalityOption(emoji: "😏", title: "Flirty & Toxic"),
        PersonalityOption(emoji: "😜", title: "Flirty & Funny"),
        PersonalityOption(emoji: "🥰", title: "Romantic & Positive"),
        PersonalityOption(emoji: "😎", title: "Dominant & Confident"),
        PersonalityOption(emoji: "🤗", title: "Shy & Supportive"),
        PersonalityOption(emoji: "🤩", title: "Funny & Creative"),
        PersonalityOption(emoji: "🤓", title: "Funny & Nerd")
    ]
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
 
    var body: some View {
        ZStack {
            Color.darkBlue
              .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Choose Personality")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                    .padding(.top, 50)
                
                Text("Characteristics of your AI Friend")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding(.bottom, 30)
                    .multilineTextAlignment(.center)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(personalities) { personality in
                        PersonalityCard(emoji: personality.emoji, title: personality.title, isSelected: selectedPersonality == personality.id)
                            .onTapGesture {
                                selectedPersonality = personality.id
                            }
                    }
                }
                .padding(.horizontal)
               
                Spacer()
                
                Button(action: {
                    // Handle create action
                    path.append("ProView")
                }) {
                    Text("Create Your AI Friend")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(32)
                        .padding(.horizontal, 40)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            CustomBackButton()
          }
        }
        .onAppear {
            // Set the default selection when the view appears
            if selectedPersonality == nil {
                selectedPersonality = personalities.first?.id
            }
        }
    }
}

struct PersonalityCard: View {
    let emoji: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Text(emoji)
                .font(.system(size: 30))
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color(white: 0.2))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)
        )
    }
}

struct PersonalitySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalitySelectionView(path: .constant(NavigationPath()))
    }
}
