import SwiftUI

struct ContentView: View {
  
  @State private var searchText = ""
  @State private var showCancelButton: Bool = false
  
  @ObservedObject var viewModel = ContentViewViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        
          HStack {
            HStack {
              Image(systemName: "magnifyingglass")

              TextField("search", text: $viewModel.searchString, onEditingChanged: { isEditing in
                self.showCancelButton = true
              }, onCommit: {
                viewModel.getItems()
//                Service.shared.loadData(description: searchText)
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
        
//        SearchBarView(searchText: $viewModel.searchString)
          
        List(viewModel.items) { item in
          NavigationLink(destination: DetailView(item: item)) {
            VStack(alignment: .leading) {
              Text(item.name)
                .font(.headline)
              Text("language: \(item.languageWrappedValue)")
                .foregroundColor(.secondary)
              Text("Stars: \(item.starsWrappedValue)")
              Text("Forks: \(item.forksWrappedValue)")
              Text("License: \(item.license?.name ?? "Unknown license")")
            }
          }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Git Search")
      }
      
      if viewModel.isLoading { LoadingView() }
    }
  }
  
//  func loadData(description: String) {
//    guard let url = URL(string: "https://api.github.com/search/repositories?q=\(description.replacingOccurrences(of: " ", with: "+"))") else {
//      print("Invalid URL")
//      return
//    }
//
//    let request = URLRequest(url: url)
//
//    URLSession.shared.dataTask(with: request) { data, response, error in
//      if let data = data {
//        if let results = try? JSONDecoder().decode([Item].self, from: data) {
//          DispatchQueue.main.async {
//            viewModel.items = results
//          }
//          return
//        }
//      }
//      print("Error: \(error?.localizedDescription ?? "Unknown error")")
//    }
//    .resume()
//  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
