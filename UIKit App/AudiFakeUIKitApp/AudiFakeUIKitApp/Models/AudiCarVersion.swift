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

struct AudiCarSubVersion: Decodable {
    var subVersionCompleteName: String?
    var subVersionShortName: String?
    var motorizationData: AudiCarMotorization?
    var dimentionsData: AudiCarDimentions?
    var assistanceAndSafetySystems: [AudiAssistanceAndSafetySystem]?
    var infotainment: [AudiAssistanceAndSafetySystem]?
    var interiorsAndComfort: [AudiAssistanceAndSafetySystem]?
    var exterior: [AudiAssistanceAndSafetySystem]?
    var sLinePackage: [AudiAssistanceAndSafetySystem]?
}

struct AudiCarMotorization: Decodable {
    var displacement: String?
    var engine: String?
    var power: String?
    var torque: String?
    var traction: String?
    var transmission: String?
    var maximumSpeed: String?
    var acceleration0to100KmByHr: String?
    var fuelEfficiency: String?
    var CO2emissions: String?
}

struct AudiCarDimentions: Decodable {
    var length: String?
    var width: String?
    var height: String?
    var distanceBetweenAxis: String?
    var emptyWeightWithDriver: Int?
    var trunkCapacity: Int?
    var fuelTankCapacity: Int
    var numberOfDoors: Int
}

struct AudiAssistanceAndSafetySystem: Decodable {
    var name: String?
    var isIncluded: Bool = false
    var isOptional: Bool = false
}
