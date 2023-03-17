//
//  AudiCarEntity.swift
//  
//
//  Created by Javier Cruz Santiago on 15/03/23.
//

import Foundation
import Vapor

struct AudiCarEntity: Content {
    var modelId: String?
    var modelName: String?
    var modelYear: Int?
    var imageUrl: String?
    var initialPrice: Double?
    var versions: [AudiCarVersion]?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.modelId, forKey: .modelId)
        try container.encode(self.modelName, forKey: .modelName)
        try container.encode(self.modelYear, forKey: .modelYear)
        try container.encode(self.imageUrl, forKey: .imageUrl)
        try container.encode(self.initialPrice, forKey: .initialPrice)
        try container.encode(self.versions, forKey: .versions)
    }
}

struct AudiCarVersion: Content {
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
