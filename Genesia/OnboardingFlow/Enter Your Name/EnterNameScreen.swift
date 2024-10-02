
//
//  EnterNameScreen.swift
//  Genesia
//
//  Created by Gehad Gamal on 28/09/2024.
//




import SwiftUI
enum UserNamePushedFrom:Hashable {
    case landing
    case startNewChat
}

@MainActor
struct EnterNameScreen: View {
    
    @State private var isContinueButtonDisabled:Bool = true
    @Binding var isFromStartNewChat:Bool
    @EnvironmentObject private var vm:LandingFlowViewModel
    @State private var text:String = ""
    @FocusState private var isFocused: Bool
    @Binding var path:NavigationPath
    
    var body: some View {
        ZStack {
            Color.darkBlue
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                whatIsYourNameView
                introduceYourselfView
                textFieldView
                Spacer()
                CustomContinueButton(title: "Continue",
                                     titleColor: .darkBlue,
                                     isDisabled: $isContinueButtonDisabled)
                .onTapGesture {
                    path.append("PronounSelectionScreen")
                }
                .allowsHitTesting(!isContinueButtonDisabled)
                .padding(.bottom, 40)
            }
        }.navigationBarBackButtonHidden()
        
            .toolbar {
                if isFromStartNewChat {
                    ToolbarItem(placement: .topBarLeading) {
                        CustomBackButton()
                    }
                }
            }
            .onAppear {
                isContinueButtonDisabled = vm.userChoices.username.isEmpty
                text = vm.userChoices.username
                isFocused.toggle()
            }
    }
}

#Preview {
    EnterNameScreen(isFromStartNewChat: .constant(false),path: .constant(NavigationPath()))
        .environmentObject(LandingFlowViewModel())
}

extension EnterNameScreen {
    private var whatIsYourNameView:some View {
        Text("What's your name?")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.top,120)
    }
    
    private var introduceYourselfView:some View {
        Text("Introduce yourself to your friend")
            .font(.callout)
            .foregroundColor(.gray)
            .padding(.bottom, 30)
    }
    
    private var textFieldView: some View {
        ZStack {
            TextField("", text: $text,
                      prompt: Text("Enter your name").foregroundColor(.gray))
            .multilineTextAlignment(.center)
            .font(.system(size: 25))
            .keyboardShortcut(.end)
            .focused($isFocused)
            .foregroundStyle(.white)
            .onChange(of: text) { oldValue, newValue in
                vm.userChoices.username = newValue
                withAnimation {
                    isContinueButtonDisabled = newValue.isEmpty
                }
            }
            .onSubmit {
                guard !vm.userChoices.username.isEmpty else { return }
            }
        }.frame(width: 200, height: 100, alignment: .center)
        
    }
}
