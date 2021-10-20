//
//  RepositoryListViewModel.swift
//  SearchGitRepositorySwiftUI
//
//  Created by Дмитрий Геращенко on 15.10.2021.
//

import Foundation

final class ContentViewViewModel: ObservableObject {
  
  @Published var searchString = ""
  @Published var items = [Item]()
  @Published var isLoading = false
  @Published var alertItem: AlertItem?
  
  func getItems() {
    NetworkManager.shared.getRepository(description: searchString) { [self] result in
      DispatchQueue.main.async {
        isLoading = true
        
        switch result {
        case .success(let items):
          self.items = items
        case .failure(let error):
          
          switch error {
          case .invalidURL:
            alertItem = AlertContext.invalidURL
          case .unableToComplete:
            alertItem = AlertContext.unableToComplete
          case .InvalidResponse:
            alertItem = AlertContext.invalidResponse
          case .invalidData:
            alertItem = AlertContext.invalidData
          }
        }
      }
    }
  }
}
