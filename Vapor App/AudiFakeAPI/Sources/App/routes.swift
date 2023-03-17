import Foundation
import Vapor

func routes(_ app: Application) throws {
    app.get("CarList.json") { req async throws -> Response in
        let filePath = req.application.directory.publicDirectory + "CarList.json"
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw Abort(.notFound)
        }
        let response = Response(status: .ok, body: .init(data: fileData))
        response.headers.contentType = .json
        return response
    }
    
    app.get("audiAPI", "carList") { req async throws -> [AudiCarEntity] in
        let filePath = req.application.directory.publicDirectory + "CarList.json"
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw Abort(.notFound)
        }
        let cars: [AudiCarEntity] = try JSONDecoder().decode([AudiCarEntity].self, from: fileData)
        return cars
    }
    
    app.get("audiAPI",":model",":version") { req async throws -> Response in
        guard let model = req.parameters.get("model"),
              let version = req.parameters.get("version") else {
            throw Abort(.internalServerError)
        }
        let filePath = "\(req.application.directory.publicDirectory)/\(model)/\(version).json"
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw Abort(.notFound)
        }
        return Response(status: .ok, body: .init(data: fileData))
    }
}
