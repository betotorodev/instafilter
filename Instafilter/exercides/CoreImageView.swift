//
//  CoreImageView.swift
//  Instafilter
//
//  Created by Beto Toro on 8/08/22.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct CoreImageView: View {
  @State private var image: Image?
  
  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
    }
    .onAppear(perform: loadImage)
  }
  
  func loadImage() {
    guard let inputImage = UIImage(named: "Example") else { return }
    let beginImage = CIImage(image: inputImage)

    let context = CIContext()
    let currentFilter = CIFilter.crystallize()
    currentFilter.inputImage = beginImage

    let amount = 1.0

    let inputKeys = currentFilter.inputKeys

    if inputKeys.contains(kCIInputIntensityKey) {
        currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
    
    // get a CIImage from our filter or exit if that fails
    guard let outputImage = currentFilter.outputImage else { return }

    // attempt to get a CGImage from our CIImage
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
        // convert that to a UIImage
        let uiImage = UIImage(cgImage: cgimg)

        // and convert that to a SwiftUI image
        image = Image(uiImage: uiImage)
    }
  }
}

struct CoreImageView_Previews: PreviewProvider {
  static var previews: some View {
    CoreImageView()
  }
}
