import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    // your code here
    let client = try app.make(Client.self)
    let urlString = "http://vapor.codes"
    
    let rep = try client.get(urlString).wait()
    print(rep)
}
