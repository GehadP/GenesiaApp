//
//  AgeSelectionView.swift
//  Genesia
//
//  Created by Gehad Gamal on 29/09/2024.
//

import SwiftUI

struct AgeSelectionView: View {
    @State private var selectedAge: Int = 18
    let availableAges = Array(18...40).reversed()
    @Binding var path:NavigationPath
    @EnvironmentObject var vm:LandingFlowViewModel
    var body: some View {
       
            ZStack{
                Color.darkBlue
                  .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    
                    Text("Kk's Age")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                        .padding(.top, 50)
                        
                    Text("You can get a more intimate\nexperience by choosing the age")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.bottom, 30)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Picker("Age", selection: $selectedAge) {
                        ForEach(availableAges, id: \.self) { age in
                            Text("\(age)").tag(age)
                        }
                    } .onChange(of: selectedAge) { oldValue, newValue in
                        vm.userChoices.aiAge = newValue
                      }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                    .datePickerStyle(WheelDatePickerStyle())
                    .preferredColorScheme(.light)
                    .labelsHidden()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipped()
                    .padding()
                    .colorInvert()
                    
                    Spacer()
                    
                    Button(action: {
                        // Handle continue action
                        print("Selected age: \(selectedAge)")
                        path.append("PersonalitySelectionView")
                    })  {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.darkBlue)
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


struct AgeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AgeSelectionView(path: .constant(NavigationPath()))
    }
}
