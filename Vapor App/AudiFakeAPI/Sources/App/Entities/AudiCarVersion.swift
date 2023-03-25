import Foundation
import Vapor

final class AudiCarVersion: Content {
    var versionId: String?
    var versionName: String?
    var initialPrice: Double?
    var coverImageUrl: String?
    var frontImageUrl: String?
    var stock: Int?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.versionId, forKey: .versionId)
        try container.encode(self.versionName, forKey: .versionName)
        try container.encode(self.initialPrice, forKey: .initialPrice)
        try container.encode(self.coverImageUrl, forKey: .coverImageUrl)
        try container.encode(self.frontImageUrl, forKey: .frontImageUrl)
        try container.encode(self.stock, forKey: .stock)
    }
}
