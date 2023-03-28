import Foundation

class AudiCarModel: Decodable, Hashable {
    var modelId: String?
    var modelName: String?
    var modelYear: Int?
    var imageUrl: String?
    var initialPrice: Double?
    var versions: [AudiCarVersion]?
    
    static func == (lhs: AudiCarModel, rhs: AudiCarModel) -> Bool {
            return lhs.modelId == rhs.modelId
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(modelId)
            hasher.combine(modelYear)
        }
}
