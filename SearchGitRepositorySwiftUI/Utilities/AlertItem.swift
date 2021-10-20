//
//  AlertItem.swift
//  SearchGitRepositorySwiftUI
//
//  Created by Дмитрий Геращенко on 15.10.2021.
//

import SwiftUI

struct AlertItem: Identifiable {
  var id = UUID()
  var title: Text
  var message: Text
  var dismissButton: Alert.Button?
}

enum AlertContext {
  static let invalidURL = AlertItem(title: Text("Server error"), message: Text("There is an error trying to reach the server. Please contact support"), dismissButton: .default(Text("OK")))
  
  static let unableToComplete = AlertItem(title: Text("Server error"), message: Text("Unable to complete your request at this time. Please check your connection"), dismissButton: .default(Text("OK")))
  
  static let invalidResponse = AlertItem(title: Text("Server error"), message: Text("Invalid response from the server. Please try again or contact support"), dismissButton: .default(Text("OK")))
  
  static let invalidData = AlertItem(title: Text("Server error"), message: Text("The data received from the server was invalid. Please try again or contact support"), dismissButton: .default(Text("OK")))
}
