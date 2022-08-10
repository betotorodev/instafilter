//
//  ContentView.swift
//  Instafilter
//
//  Created by Beto Toro on 7/08/22.
//

import SwiftUI

struct ContentView: View {
  @State private var image: Image?
  @State private var filterIntensity = 0.5
  
  func save() {
  }
  
  var body: some View {
    NavigationView {
      VStack {
        ZStack {
          Rectangle()
            .fill(.secondary)
          
          Text("Tap to select a picture")
            .foregroundColor(.white)
            .font(.headline)
          
          image?
            .resizable()
            .scaledToFit()
        }
        .onTapGesture {
          // select an image
        }
        
        HStack {
          Text("Intensity")
          Slider(value: $filterIntensity)
        }
        .padding(.vertical)
        
        HStack {
          Button("Change Filter") {
            // change filter
          }
          
          Spacer()
          
          Button("Save", action: save)
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
