//
//  SearchBarView.swift
//  TryFetchDataOnGit
//
//  Created by Дмитрий Геращенко on 30.07.2021.
//

import SwiftUI

struct SearchBarView: View {
  
  @ObservedObject var viewModel = ContentViewViewModel()
  @Binding var searchText: String
  @State private var showCancelButton = false
  
    var body: some View {
      HStack {
        HStack {
          Image(systemName: "magnifyingglass")
          
          TextField("search", text: $viewModel.searchString, onEditingChanged: { isEditing in
            self.showCancelButton = true
          }, onCommit: {
            viewModel.getItems()
          }).foregroundColor(.primary)
          
          Button(action: {
            self.searchText = ""
          }) {
            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
          }
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
        
        if showCancelButton  {
          Button("Cancel") {
            UIApplication.shared.endEditing(true)
            // this must be placed before the other commands here
            self.searchText = ""
            self.showCancelButton = false
          }
          .foregroundColor(Color(.systemBlue))
        }
      }
      .padding(.horizontal)
      .navigationBarHidden(showCancelButton)
      .animation(.default)
    }
}

extension UIApplication {
  func endEditing(_ force: Bool) {
    self.windows
      .filter{$0.isKeyWindow}
      .first?
      .endEditing(force)
  }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
  var gesture = DragGesture().onChanged{_ in
    UIApplication.shared.endEditing(true)
  }
  func body(content: Content) -> some View {
    content.gesture(gesture)
  }
}

extension View {
  func resignKeyboardOnDragGesture() -> some View {
    return modifier(ResignKeyboardOnDragGesture())
  }
}
