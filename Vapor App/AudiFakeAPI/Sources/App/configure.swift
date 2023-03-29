import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // coment if you don't want to expose your server in your local network
    app.http.server.configuration.address = BindAddress.hostname("0.0.0.0", port: 8080)
    
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
}
