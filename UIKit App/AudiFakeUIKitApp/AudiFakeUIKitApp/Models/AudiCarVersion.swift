import Foundation

struct AudiCarVersion: Decodable {
    var versionId: String?
    var versionName: String?
    var initialPrice: Double?
    var imageUrl: String?
    var stock: Int?
}
