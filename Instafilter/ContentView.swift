//
//  ContentView.swift
//  Instafilter
//
//  Created by Beto Toro on 7/08/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
  @State private var image: Image?
  @State private var filterIntensity = 0.5
  @State private var filterRadius = 5.0
  @State private var filterScale = 5.0
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  @State private var processedImage: UIImage?
  @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
  @State private var showingFilterSheet = false
  let context = CIContext()
  
  func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    loadImage()
  }
  func loadImage() {
    guard let inputImage = inputImage else { return }
    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }
  func save() {
    guard let processedImage = processedImage else { return }
    
    let imageSaver = ImageSaver()
    imageSaver.successHandler = {
      print("Success!")
    }
    
    imageSaver.errorHandler = {
      print("Oops: \($0.localizedDescription)")
    }
    
    imageSaver.writeToPhotoAlbum(image: processedImage)
  }
  func applyProcessing() {
    let inputKeys = currentFilter.inputKeys
    
    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 50, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }
    
    guard let outputImage = currentFilter.outputImage else { return }
    
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
      processedImage = uiImage
    }
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
        
        if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
          HStack {
            Text("Intensity")
            Slider(value: $filterIntensity)
              .onChange(of: filterIntensity) { _ in applyProcessing() }
          }
          .padding(.vertical)
        }
        
        if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
          HStack {
            Text("Radius")
            Slider(value: $filterRadius, in: 0...200)
              .onChange(of: filterRadius) { _ in applyProcessing() }
          }
          .padding(.vertical)
        }
        
        if currentFilter.inputKeys.contains(kCIInputScaleKey) {
          HStack {
            Text("Scale")
            Slider(value: $filterScale, in: 0...10)
              .onChange(of: filterScale) { _ in applyProcessing() }
          }
          .padding(.vertical)
        }
        
        HStack {
          Button("Change Filter") {
            showingFilterSheet = true
          }
          
          Spacer()
          
          Button("Save", action: save)
            .disabled(image == nil)
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
      .onChange(of: inputImage) { _ in loadImage() }
      .sheet(isPresented: $showingImagePicker) {
        ImagePicker(image: $inputImage)
      }
      .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
        Button("Crystallize") { setFilter(CIFilter.crystallize()) }
        Button("Comic Effect") { setFilter(CIFilter.comicEffect()) }
        Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
        Button("Pixellate") { setFilter(CIFilter.pixellate()) }
        Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
        Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
//        Button("Vignette") { setFilter(CIFilter.vignette()) }
        Button("affine clamp") { setFilter(CIFilter.affineClamp()) }
        Button("thermal") { setFilter(CIFilter.thermal()) }
        Button("bloom") { setFilter(CIFilter.bloom()) }
        Button("Cancel", role: .cancel) { }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
