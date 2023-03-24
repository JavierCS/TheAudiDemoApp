import Foundation

class AudiCarModel: Decodable {
    var modelId: String?
    var modelName: String?
    var modelYear: Int?
    var imageUrl: String?
    var initialPrice: Double?
    var versions: [AudiCarVersion]?
}

extension AudiCarModel: ModelCollectionViewCellProtocol {
    func getImageUrl() -> URL? {
        guard let url = imageUrl else { return nil }
        return URL(string: url)
    }
}
