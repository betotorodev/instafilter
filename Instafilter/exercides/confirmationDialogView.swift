//
//  confirmationDialogView.swift
//  Instafilter
//
//  Created by Beto Toro on 7/08/22.
//

import SwiftUI

struct confirmationDialogView: View {
  @State private var showingConfirmation = false
  @State private var backgroundColor = Color.white
  
  var body: some View {
    Text("Hello, World!")
      .frame(width: 300, height: 300)
      .background(backgroundColor)
      .onTapGesture {
        showingConfirmation = true
      }
      .confirmationDialog("Change background", isPresented: $showingConfirmation) {
        Button("Red") { backgroundColor = .red }
        Button("Green") { backgroundColor = .green }
        Button("Blue") { backgroundColor = .blue }
        Button("Cancel", role: .cancel) { }
      } message: {
        Text("Select a new color")
      }
  }
}

struct confirmationDialogView_Previews: PreviewProvider {
  static var previews: some View {
    confirmationDialogView()
  }
}
