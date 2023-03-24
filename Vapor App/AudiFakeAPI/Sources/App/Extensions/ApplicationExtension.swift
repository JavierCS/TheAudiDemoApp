import Foundation
import Vapor

extension Application {
    // MARK: - Server Data
    func getServerUrl() -> URL? {
        let config = http.server.configuration
        let scheme = config.tlsConfiguration != nil ? "https" : "http"
        let hostname = config.hostname
        let port = config.port

        return URL(string: "\(scheme)://\(hostname):\(port)")
    }
    
    private func getFileNames(forFolderAt path: String) -> [String]? {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: path) else {
            debugPrint("\t[NOT FOUND] - No encuentro la carpeta: \n\t\(path)")
            return nil
        }
        guard let files = try? fileManager.contentsOfDirectory(atPath: path) else {
            debugPrint("\t[INTERNAL SERVER ERROR] - Error al obtener archivos dentro de la carpeta: \n\t\(path)")
            return nil
        }
        return files
    }
    
    // MARK: Resources URL
    func getModelImageUrl(for model: String) -> URL? {
        guard let serverUrl = getServerUrl() else { return nil }
        return serverUrl.appendingPathComponent("Resources").appendingPathComponent(model).appendingPathComponent("\(model).png")
    }
}
