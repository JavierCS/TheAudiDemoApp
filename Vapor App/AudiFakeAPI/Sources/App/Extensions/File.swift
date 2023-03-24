import Foundation
import Vapor

extension Application {
    func getDetailFilePath(for model: String, inVersion version: String) -> String {
        let publicPath = directory.publicDirectory
        let resourcesPath = publicPath.appending("Resources")
        let modelPath = resourcesPath.appending("/\(model)")
        let versionPath = modelPath.appending("/\(version)")
        let detailFilePath = versionPath.appending("/\(version).json")
        return detailFilePath
    }
}
