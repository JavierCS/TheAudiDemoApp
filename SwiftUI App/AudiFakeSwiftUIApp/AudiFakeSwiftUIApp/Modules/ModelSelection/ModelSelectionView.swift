import SwiftUI

struct ModelSelectionView: View {
    @State var cars: [AudiCarModel] = []
    
    var body: some View {
        ModelGridView(cars: $cars)
            .navigationTitle("Elige un Audi")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                fetchAudiModels()
            }
    }
    
    func fetchAudiModels() {
        guard let url = URL(string: "http://127.0.0.1:8080/audiAPI/carList") else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard let data = data,
                  let response = try? JSONDecoder().decode([AudiCarModel].self, from: data) else {
                DispatchQueue.main.async {
                    // TODO: Show Error
                    debugPrint(error as Any)
                }
                return
            }
            DispatchQueue.main.async {
                self.cars = response
            }
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ModelSelectionView()
    }
}
