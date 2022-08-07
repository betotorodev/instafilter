//
//  OnChangeView.swift
//  Instafilter
//
//  Created by Beto Toro on 7/08/22.
//

import SwiftUI

struct OnChangeView: View {
  @State private var blurAmount = 0.0
  
  var body: some View {
    VStack {
      Text("Hello, World!")
        .blur(radius: blurAmount)
      
      Slider(value: $blurAmount, in: 0...20)
        .onChange(of: blurAmount) { newValue in
          print("New value is \(newValue)")
        }
    }
  }
}

struct OnChangeView_Previews: PreviewProvider {
  static var previews: some View {
    OnChangeView()
  }
}
