import Foundation

struct AudiCarVersion: Decodable {
    var versionId: String?
    var versionName: String?
    var initialPrice: Double?
    var coverImageUrl: String?
    var frontImageUrl: String?
    var subVersions: [AudiCarSubVersion]?
    var stock: Int?
}

extension AudiCarVersion: CarVersionTableViewCellProtocol {
    func getModelVersion() -> String? {
        return versionName
    }
    
    func getInitialPrice() -> String? {
        guard let initialPrice = initialPrice,
              let formattedPrice = initialPrice.currencyFormatted() else {
            return "Precio no disponible"
        }
        return "Desde: \(formattedPrice)"
    }
    
    func getVersionImageUrl() -> URL? {
        guard let url = frontImageUrl else { return nil }
        return URL(string: url)
    }
}
