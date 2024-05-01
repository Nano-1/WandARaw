//
//  SplashScreenView.swift
//  WandARaw
//
//  Created by Risa on 30/04/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color(red: 0.23, green: 0.21, blue: 0.38).edgesIgnoringSafeArea(.all)
            Image("bg")
                    .resizable()
                    .scaledToFit()
            Image("accent")
                .resizable()
                .scaledToFit()
                .frame(width: 235, height: 586)
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 240, height: 240)
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
