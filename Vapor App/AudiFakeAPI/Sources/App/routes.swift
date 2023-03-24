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
    
    app.get("audiAPI", "carList") { req async throws -> [AudiCarModel] in
        let filePath = req.application.directory.publicDirectory + "CarList.json"
        guard FileManager.default.fileExists(atPath: filePath) else {
            throw Abort(.notFound)
        }
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw Abort(.internalServerError)
        }
        let cars: [AudiCarModel] = try JSONDecoder().decode([AudiCarModel].self, from: fileData)
        return cars
    }
    
    app.get("audiAPI",":model",":version") { req async throws -> Response in
        guard let model = req.parameters.get("model"),
              let version = req.parameters.get("version") else {
            throw Abort(.internalServerError)
        }
        let filePath = req.application.getDetailFilePath(for: model, inVersion: version)
        guard FileManager.default.fileExists(atPath: filePath) else {
            throw Abort(.notFound)
        }
        guard let fileData = FileManager.default.contents(atPath: filePath) else {
            throw Abort(.internalServerError)
        }
        let response = Response(status: .ok, body: .init(data: fileData))
        response.headers.contentType = .json
        return response
    }
    
    app.get("audiAPI","versionDetails") { req async throws -> Response in
        guard let query = req.url.query else {
            throw Abort(.badRequest)
        }
        var urlComponents = URLComponents()
        urlComponents.query = query
        guard let queryItems = urlComponents.queryItems,
              let model = queryItems.first(where: { $0.name == "model" })?.value,
              let version = queryItems.first(where: { $0.name == "version" })?.value else {
            throw Abort(.badRequest)
        }
        let detailFilePath = req.application.getDetailFilePath(for: model, inVersion: version)
        guard FileManager.default.fileExists(atPath: detailFilePath) else { throw Abort(.notFound) }
        guard let fileData = FileManager.default.contents(atPath: detailFilePath) else { throw Abort(.internalServerError) }
        let response = Response(status: .ok, body: .init(data: fileData))
        response.headers.contentType = .json
        return response
    }
}
