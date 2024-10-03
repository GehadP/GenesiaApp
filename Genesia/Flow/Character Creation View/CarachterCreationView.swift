//
//  CarachterCreationView.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//

import SwiftUI

struct CharacterCreationView: View {
    @EnvironmentObject var vm:LandingFlowViewModel
    @State private var isContinueButtonDisabled:Bool = true
    @State private var selectedGender: String? = "Female"
    @State private var aiName:String = ""
    @FocusState private var isFocused:Bool
    @Binding var path:NavigationPath
    
    var body: some View {
        ZStack {
            backgroundView
            VStack {
                Text("Choose name & gender")
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                Spacer()
                gradientView
                    .ignoresSafeArea()
            }
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        TextField("", text: $aiName,
                                  prompt: Text("Enter Name").foregroundColor(.gray))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .frame(width: 200)
                        .focused($isFocused)
                        .onChange(of: aiName) { oldValue, newValue in
                            vm.userChoices.aiName = newValue
                            isContinueButtonDisabled = newValue.isEmpty
                        }
                        continueButton
                            .padding(.horizontal)
                            .padding(.bottom,30)
                    }
                    genderButtons
                }.frame(width: 350, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }.padding(.bottom,10)
        }.navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomBackButton()
                }
            }
            .onAppear {
                selectedGender = vm.userChoices.aiGender
                isFocused.toggle()
            }
    }
}

#Preview {
    let vm = LandingFlowViewModel()
    vm.userChoices.selectedAvatar = "person1"
    return CharacterCreationView(path: .constant(NavigationPath()))
        .environmentObject(vm)
}

extension CharacterCreationView {
    private var gradientView:some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.clear)
                .frame(height:350)
                .overlay {
                    LinearGradient(
                        gradient: Gradient(colors: [.darkBlue, .clear]),
                        startPoint: .center,
                        endPoint: .top)
                }
                .allowsHitTesting(false)
        }
    }
    private var backgroundView: some View {
        Image( vm.userChoices.selectedAvatar ?? "")
            .resizable()
            .ignoresSafeArea()
    }
    private var genderButtons:some View {
        HStack {
            GenderButton(title: "Female",
                         isSelected: $selectedGender) {
                vm.userChoices.aiGender = "Female"
            }
            GenderButton(title: "Male",
                         isSelected: $selectedGender) {
                vm.userChoices.aiGender = "Male"
            }
            GenderButton(title: "Non-Binary",
                         isSelected: $selectedGender) {
                vm.userChoices.aiGender = "Non-Binary"
            }
        }
    }
    private var continueButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 30, height: 30)
            Image(systemName: "chevron.right")
                .foregroundStyle(.darkBlue)
                .font(.system(size: 15))
                .bold()
        }.opacity(isContinueButtonDisabled ? 0.4 : 1)
            .animation(.easeInOut, value: isContinueButtonDisabled)
            .onAppear {
                if !vm.userChoices.aiName.isEmpty {
                    isContinueButtonDisabled = false
                }
            }
            .allowsHitTesting(!isContinueButtonDisabled)
            .onTapGesture {
                path.append("AgeSelectionView")
                
            }
    }
}


struct GenderButton: View {
    let title: String
    @Binding var isSelected: String?
    let action:() -> Void
    
    var body: some View {
        Button(action: {
            isSelected = title
            action()
        }) {
            Text(title)
                .padding()
                .frame(height:40)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected == title ? Color.white : Color.clear)
                )
        }
    }
}
