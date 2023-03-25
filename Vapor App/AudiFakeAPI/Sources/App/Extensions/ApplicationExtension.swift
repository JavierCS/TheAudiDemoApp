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
    
    // MARK: - Paths Management
    private func getResourcesPath() -> String {
        return "/Resources"
    }
    
    private func getModelPath(for model: String) -> String {
        return getResourcesPath().appending("/\(model)")
    }
    
    private func getVersionPath(for model: String, inVersion version: String) -> String {
        return getModelPath(for: model).appending("/\(version)")
    }
    
    private func getBodyPath(for model: String, inVersion version: String) -> String {
        return getVersionPath(for: model, inVersion: version).appending("/body")
    }
    
    private func getCarruselPath(for model: String, inVersion version: String) -> String {
        return getVersionPath(for: model, inVersion: version).appending("/carrusel")
    }
    
    private func getLightPath(for model: String, inVersion version: String) -> String {
        return getVersionPath(for: model, inVersion: version).appending("/light")
    }
    
    // MARK: - Files Management
    func getDetailFilePath(for model: String, inVersion version: String) -> String {
        return getResourcesPath().appending("/\(model)/\(version)/\(version).json")
    }
    
    // MARK: Resources URL
    private func getResourcesUrl() -> URL? {
        return getServerUrl()?.appendingPathComponent("Resources")
    }
    
    private func getModelUrl(for model: String) -> URL? {
        return getResourcesUrl()?.appendingPathComponent(model)
    }
    
    private func getVersionUrl(for model: String, inVersion version: String) -> URL? {
        return getModelUrl(for: model)?.appendingPathComponent(version)
    }
    
    private func getBodyUrl(for model: String, inVersion version: String) -> URL? {
        return getVersionUrl(for: model, inVersion: version)?.appendingPathComponent("body")
    }
    
    private func getCarruselUrl(for model: String, inVersion version: String) -> URL? {
        return getVersionUrl(for: model, inVersion: version)?.appendingPathComponent("carrusel")
    }
    
    func getModelImageUrl(for model: String) -> URL? {
        guard let serverUrl = getServerUrl() else { return nil }
        return serverUrl.appendingPathComponent("Resources").appendingPathComponent(model).appendingPathComponent("\(model).png")
    }
    
    func getVersionCoverImageUrl(for model: String, inVersion version: String) -> URL? {
        return getVersionUrl(for: model, inVersion: version)?.appendingPathComponent("cover.png")
    }
    
    func getVersionFrontImageUrl(for model: String, inVersion version: String) -> URL? {
        return getVersionUrl(for: model, inVersion: version)?.appendingPathComponent("front.png")
    }
}
