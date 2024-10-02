//
//  BirthdaySelectionScreen.swift
//  Genesia
//
//  Created by Gehad Gamal on 28/09/2024.
//

import SwiftUI

struct BirthdaySelectionScreen: View {
    @EnvironmentObject var vm:LandingFlowViewModel
    @State private var selectedDate: Date = Date()
    @State var navigateToNextScreen: Bool = false
    @Binding var path:NavigationPath
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
        let max = Date()
        return min...max
    }
    var body: some View {
        
        ZStack {
            Color.darkBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    yourDateOfBirthTitle
                    titleDescription
                }
                .padding(.horizontal,80)
                Spacer()
                datePicker
                Spacer()
                Button(action: {
                    navigateToNextScreen = true
                    path.append("InterestsSelectionView")
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
        } .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomBackButton()
                }
            }
    }
}

#Preview {
    BirthdaySelectionScreen( path: .constant(NavigationPath()))
}
extension BirthdaySelectionScreen {
    private var  yourDateOfBirthTitle:some View {
        Text("Your date of birth")
            .font(.title)
            .foregroundColor(.white)
            .padding(.bottom, 10)
            .padding(.top, 50)
    }
    private var  titleDescription:some View {
        Text("Knowing your date of birth makes your experience more relevent ")
            .font(.subheadline)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
    }
    private var  datePicker:some View {
        DatePicker("Birthday", selection: $selectedDate,in:dateClosedRange, displayedComponents: [.date])
            .datePickerStyle(WheelDatePickerStyle())
            .preferredColorScheme(.light)
            .labelsHidden()
            .frame(maxWidth: .infinity, maxHeight: 400)
            .clipped()
            .padding()
            .colorInvert()
            .onChange(of: selectedDate) { oldValue, newValue in
                vm.userChoices.dateOfBirth = newValue
            }
    }
}
