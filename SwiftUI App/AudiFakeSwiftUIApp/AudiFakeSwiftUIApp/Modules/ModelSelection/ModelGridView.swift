import SwiftUI

struct ModelGridView: View {
    @Binding var cars: [AudiCarModel]
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(cars, id: \.self) { car in
                        ModelGridItemView(urlString: car.imageUrl)
                            .frame(height: geometry.size.width / 2)
                    }
                }
            }
        }
    }
}
