//
//  SearchBarView.swift
//  TryFetchDataOnGit
//
//  Created by Дмитрий Геращенко on 30.07.2021.
//

import SwiftUI

struct SearchBarView: View {
  
  @State private var searchText = ""
  @State private var showCancelButton = false
  
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
