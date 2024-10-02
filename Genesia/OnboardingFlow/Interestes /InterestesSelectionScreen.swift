//
//  InterestesSelectionScreen.swift
//  Genesia
//
//  Created by Gehad Gamal on 28/09/2024.
//

import SwiftUI

// Define a struct for interest items that conforms to Hashable
struct InterestItem: Hashable {
    let icon: String
    let text: String
}

struct InterestsSelectionView: View {
    let interests = [
        InterestItem(icon: "🎨", text: "Art and Creativity"),
        InterestItem(icon: "📚", text: "Literature"),
        InterestItem(icon: "🎥", text: "Movies and TV Shows"),
        InterestItem(icon: "🕺", text: "Dancing"),
        InterestItem(icon: "🐶", text: "Pets and Animals"),
        InterestItem(icon: "🌱", text: "Gardening"),
        InterestItem(icon: "🌍", text: "Volunteering"),
        InterestItem(icon: "💻", text: "Technology"),
        InterestItem(icon: "👗", text: "Fashion"),
        InterestItem(icon: "✈️", text: "Travel"),
        InterestItem(icon: "🎶", text: "Music"),
        InterestItem(icon: "⚽️", text: "Sports"),
        InterestItem(icon: "🎮", text: "Gaming"),
        InterestItem(icon: "💼", text: "Career"),
        InterestItem(icon: "🍳", text: "Cooking"),
        InterestItem(icon: "💪", text: "Fitness"),
        InterestItem(icon: "☕️", text: "Coffee"),
        InterestItem(icon: "☁️", text: "Philosophy/Existential questions"),
        InterestItem(icon: "🎭", text: "Theater and Performing Arts"),
        InterestItem(icon: "🌍", text: "Environmental Sustainability")
    ]
    
    @EnvironmentObject var vm:LandingFlowViewModel
    @State private var selectedInterests: [InterestItem] = []
    @Binding var path:NavigationPath
    var body: some View {
        ZStack {
            Color.darkBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Your Interests")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("Your 5 interests to enhance your conversations")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                ScrollView {
                    FlowLayout(items: interests, itemContent: { interest in
                        InterestButton(icon: interest.icon, interest: interest.text, isSelected: selectedInterests.contains(interest)) {
                            selectInterest(interest)
                        }
                    })
                    .padding(.horizontal)
                }
                
                Spacer()
                Button(action: {
                    print("Continue pressed with selected interests: \(selectedInterests)")
                    path.append("AIFriendSelectionView")
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedInterests.isEmpty ? Color.gray : .white)
                        .foregroundColor(selectedInterests.isEmpty ? .white:.black)
                        .cornerRadius(32)
                        .padding(.horizontal)
                }
                
                .disabled(selectedInterests.isEmpty)
            }
        } .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomBackButton()
                }
            }.onChange(of: selectedInterests) { oldValue, newValue in
            }
    }
    private func selectInterest(_ interest: InterestItem) {
        if selectedInterests.contains(interest) {
            selectedInterests.removeAll { $0 == interest }
        } else if selectedInterests.count < 5 {
            selectedInterests.append(interest)
        }
    }
}

struct InterestButton: View {
    let icon: String
    let interest: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(icon)
                    .font(.title2)
                
                Text(interest)
                    .font(.headline)
                    .padding(.leading, 8)
                
            }
            .foregroundColor(.white)
            .padding()
            .lineLimit(1)
            .frame(height: 40)
            .cornerRadius(18)
            .font(.system(size: 18))
            .background(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white.opacity(isSelected ? 1 : 0.2)))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(isSelected ? 0.3 :0.1))
            }
        }
    }
}

// FlowLayout dynamically wraps items based on their size
struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    
    var items: Data
    let itemContent: (Data.Element) -> Content
    
    @State private var totalHeight: CGFloat = .zero
    
    init(items: Data, @ViewBuilder itemContent: @escaping (Data.Element) -> Content) {
        self.items = items
        self.itemContent = itemContent
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(height: totalHeight) // Dynamic total height based on content
    }
    
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var widthAvailable = geometry.size.width
        var xPos: CGFloat = 0
        var yPos: CGFloat = 0
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.items, id: \.self) { item in
                self.itemContent(item)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(xPos - d.width) > widthAvailable) {
                            xPos = 0
                            yPos -= d.height
                        }
                        let result = xPos
                        if item == self.items.last! {
                            xPos = 0
                        } else {
                            xPos -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = yPos
                        if item == self.items.last! {
                            yPos = 0
                        }
                        return result
                    })
            }
        }
        .background(GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                self.totalHeight = geo.size.height
            }
            return Color.clear
        })
    }
}

// Preview for testing
struct InterestsSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        InterestsSelectionView(path: .constant(NavigationPath()))
    }
}
