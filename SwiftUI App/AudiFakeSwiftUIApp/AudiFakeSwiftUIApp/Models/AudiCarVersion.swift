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
