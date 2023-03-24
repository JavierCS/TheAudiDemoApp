import Foundation

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
