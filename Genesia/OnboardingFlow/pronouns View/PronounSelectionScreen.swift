
//
//  PronounSelectionScreen.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//


import SwiftUI

struct PronounSelectionScreen: View {
    
    @EnvironmentObject private var vm:LandingFlowViewModel
    @State private var selectedPronoun = "He / Him" 
    @State var navigateToNextScreen: Bool = false
    let pronouns = ["She / Her", "He / Him", "They / Them"]
    @Binding var path:NavigationPath
    var body: some View {
        
        ZStack {
            Color.darkBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    yourPronounsTitle
                    whichPersonTitle
                    
                }
                .padding(.horizontal,80)
                Spacer()
                pickerView
                Spacer()
                Button(action: {
                    navigateToNextScreen = true
                    path.append("BirthdaySelectionScreen")
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(32)
                        .padding(.horizontal, 40)
                }
                .padding(.vertical, 50)
                
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


struct PronounSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        PronounSelectionScreen( path: .constant(NavigationPath()))
    }
}


extension PronounSelectionScreen {
    private var yourPronounsTitle:some View {
        Text("Your pronouns")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.top,120)
    }
    
    private var whichPersonTitle:some View {
        Text("Which pronoun would you like your friend to call you?")
            .font(.subheadline)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .opacity(0.8)
            .padding(.bottom, 25)
    }
    
    private var pickerView:some View {
        Picker("Select your pronoun", selection: $selectedPronoun) {
            ForEach(pronouns, id: \.self) { pronoun in
                Text(pronoun)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .clipped()
        .padding()
        .onChange(of: selectedPronoun) { oldValue, newValue in
            vm.userChoices.userPronouns = newValue
        }
    }
    
}
