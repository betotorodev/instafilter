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
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
  }
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
          showingImagePicker = true
          
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
      .onChange(of: inputImage) { _ in loadImage() }
      .sheet(isPresented: $showingImagePicker) {
        ImagePicker(image: $inputImage)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
