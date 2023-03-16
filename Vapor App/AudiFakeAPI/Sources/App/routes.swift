import Foundation
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("CarsList.json") { req async throws -> Response in
        let filePath = req.application.directory.publicDirectory + "CarsList.json"
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw Abort(.notFound)
        }
        let response = Response(status: .ok, body: .init(data: fileData))
        response.headers.contentType = .json
        return response
    }
    
    app.get("audiAPI", "carList") { req async throws -> [AudiCarEntity] in
        let filePath = req.application.directory.publicDirectory + "CarsList.json"
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw Abort(.notFound)
        }
        let cars: [AudiCarEntity] = try JSONDecoder().decode([AudiCarEntity].self, from: fileData)
        return cars
    }
}
