import SwiftUI

struct ModelGridItemView: View {
    @State private var image: UIImage? = nil
    var urlString: String?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        } else {
            Image("AudiLogo")
                .onAppear {
                    guard let urlString = urlString, let url = URL(string: urlString) else { return }
                    fetchImage(at: url)
                }
        }
    }
    
    private  func fetchImage(at url: URL) {
        if let cacheImage = AudiImageCacheManager.shared.image(locatedAt: url) {
            image = cacheImage
            return
        }
        AudiImageCacheManager.shared.fetchImage(locatedAt: url) { networkImage, _ in
            image = networkImage
        }
    }
}
