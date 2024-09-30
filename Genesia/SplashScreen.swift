//
//  ContentView.swift
//  Genesia
//
//  Created by Gehad Gamal on 28/09/2024.
//

import SwiftUI

struct SplashScreen: View {
   
    var body: some View {
       
            ZStack {
                Color.darkBlue
                  .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    
                    Text("Genesia AI")
                        .font(.system(size: 36, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            .statusBar(hidden: false)// Keep status bar visible
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
