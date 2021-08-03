
import Foundation
import SwiftUI

class Service {
  
  static let shared = Service()
  
 func loadData(description: String) {
    guard let url = URL(string: "https://api.github.com/search/repositories?q=\(description.replacingOccurrences(of: " ", with: "+"))") else {
      print("Invalid URL")
      return
    }
    
    let request = URLRequest(url: url)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        if let results = try? JSONDecoder().decode(Response.self, from: data) {
          DispatchQueue.main.async {
//            self.items = results.items
          }
          return
        }
      }
      print("Error: \(error?.localizedDescription ?? "Unknown error")")
    }
    .resume()
  }
}
