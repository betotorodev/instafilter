//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Beto Toro on 8/08/22.
//

import SwiftUI

struct ImagePickerView: View {
  @State private var image: Image?
  @State private var showingImagePicker = false
  
  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
      
      Button("Select Image") {
        showingImagePicker = true
      }
    }
    .sheet(isPresented: $showingImagePicker) {
      ImagePicker()
    }
  }
}

struct ImagePickerView_Previews: PreviewProvider {
  static var previews: some View {
    ImagePickerView()
  }
}
