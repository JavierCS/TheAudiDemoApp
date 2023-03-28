import Foundation
import UIKit

enum AudiImageOrigin {
    case cache
    case network
}

class AudiImageCacheManager {
    static var shared: AudiImageCacheManager = AudiImageCacheManager()
    
    private var cache: NSCache = NSCache<NSString, UIImage>()
    
    func image(locatedAt url: URL) -> UIImage? {
        let imageKey: NSString = url.absoluteString as NSString
        guard let cacheImage = cache.object(forKey: imageKey) else { return nil }
        return cacheImage
    }
    
    func fetchImage(locatedAt url: URL, completion: @escaping (UIImage?,  AudiImageOrigin) -> Void) {
        let imageKey: NSString = url.absoluteString as NSString
        if let cacheImage = cache.object(forKey: imageKey) {
            completion(cacheImage, .cache)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] (data, urlResponse, error) in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil, .network)
                }
                return
            }
            self.cache.setObject(image, forKey: imageKey)
            DispatchQueue.main.async {
                completion(image, .network)
            }
        }.resume()
    }
}

