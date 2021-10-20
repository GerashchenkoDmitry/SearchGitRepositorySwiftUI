
import Foundation
import SwiftUI

class NetworkManager: NSObject {
  
  static let shared = NetworkManager()
  
  var jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
  
  func getRepository(description: String, completed: @escaping (Result<[Item], AppError>) -> Void) {
    
    guard let url = URL(string: "https://api.github.com/search/repositories?q=\(description.replacingOccurrences(of: " ", with: "+"))") else {
      completed(.failure(.invalidURL))
      return
    }
    
    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      
      if let _ = error {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.InvalidResponse))
        return
      }
      
      guard let data = data else {
        completed(.failure(.invalidData))
        return
      }
      
      do {
        let decodedResponse = try JSONDecoder().decode(ItemResponse.self, from: data)
        completed(.success(decodedResponse.items))
      } catch {
        completed(.failure(.invalidData))
      }
    }
    task.resume()
  }
}
    
//    let request = URLRequest(url: url)
//
//    URLSession.shared.dataTask(with: request) { data, response, error in
//      if let data = data {
//        if let results = try? JSONDecoder().decode([Item].self, from: data) {
//          DispatchQueue.main.async {
////            self.items = results.items
//            print(results)
//          }
//          return
//        }
//      }
//      print("Error: \(error?.localizedDescription ?? "Unknown error")")
//    }
//    .resume()
//  }

