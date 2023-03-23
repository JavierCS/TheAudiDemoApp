import Foundation

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
