//
//  ContentView.swift
//  Genesia
//
//  Created by Gehad Gamal on 28/09/2024.
//
import SwiftUI
struct ContentView: View {
    @State private var isSplashVisible = true
    @StateObject private var vm = LandingFlowViewModel()
    @State private var navigationPath = NavigationPath()
    var body: some View{
        ZStack {
            if isSplashVisible {
                SplashScreen()
                    .onAppear{
                        // Wait for 3 seconds before transitioning
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            withAnimation {
                                isSplashVisible = false
                            }
                        }
                    }
            }
            else {
                //EnterNameScreen()
                LandingScreen(path:$navigationPath)
                  .environmentObject(vm)
            }
        }
    }
}
